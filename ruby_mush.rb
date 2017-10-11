require 'rubygems'
require 'eventmachine'
gem 'activerecord'
gem 'colorize'
require 'active_record'
require 'colorize'


puts "--+ Starting RubyMush..."

START_LOCATION = 5

CONNECTIONS = Hash.new
COMMANDS = Array.new


ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  database: "rubymush",
  username: "root",
  password: ""
)

require_relative 'models/thing.rb'

puts "--+ Loading commands:"

Dir.glob('commands/*rb') do |item|
	require_relative(item.split('.')[0])
	if item != 'commands/command.rb'
		klass = Object.const_get(
	          File::basename(item.split('.')[0], ".rb")
	            .split("_")
	            .map(&:capitalize)
	            .join("")
	        )
		puts "  + Loaded: #{klass}"
		COMMANDS << klass.new
	end
end


for player in Thing.where(kind: 'player')
	player.connected = false
	player.save
end

module MushServer
	@user = nil

	def get_user
		return @user
	end

	def time_ago_in_words(t)
		seconds = Time.now.to_i - t.to_i
		if seconds > 86400
			return "#{seconds/86400}d"
		end
		if seconds > 3600
			return "#{seconds/3600}h"
		end
		if seconds > 60
			return "#{seconds/60}m"
		end
		return "#{seconds}s"
	end

	def post_init
		puts "--+ New connection"
		send_data File.read('welcome.txt')
	end

	def is_number?(obj)
      obj.to_s == obj.to_i.to_s
  end

	def find_thing(q)
		q.strip!
		# puts "--+ Finding thing: #{q}"
		if is_number?(q)
			return Thing.where(id: q).first
		elsif q.downcase == 'here'
			return @user.location
		elsif q.downcase == 'me'
			return @user
		else
			return Thing.where(["name like ? and location_id in (?)", "#{q}%", [@user.id, @user.location_id]]).first
		end
	end


	def connect_user(user)
		user.connected = true
		user.last_login_at = Time.now
		user.last_interaction_at = Time.now
		user.save
		CONNECTIONS[user.id] = self
		user.location.broadcast(CONNECTIONS, user, "#{user.name} has connected.\n")
		puts "--+ #{user.name} logged in"

    for c in COMMANDS
      puts "Checking: #{c.name}"
      if c.name == 'look'
        puts "LOOK!"
        result = c.execute(@user, "look")
        if result
          send_data(result)
        end
        return
      end
    end

		# for c in CONNECTIONS
		# 	puts "  + Connected user: #{c.get_user}"
		# end
	end




	def parse_command(command)
		command.strip!
		return if command == nil
		parts = command.split(' ')
		if @user == nil

			# Login commands

			if command == 'a'
				@user = Thing.where(name: 'Benji', kind: 'player').first
				connect_user(@user)
				send_data("Welcome back #{@user.name}!\n")
				return
			end

			if command == 'b'
				@user = Thing.where(name: 'test', kind: 'player').first
				connect_user(@user)
				send_data("Welcome back #{@user.name}!\n")

				return
			end


			if command.downcase.start_with? 'create'
				if command.split(' ').size == 3
					@user = Thing.create(name: command.split(' ')[1], password: command.split(' ')[2], last_login_at: Time.now, kind: 'player', location_id: START_LOCATION, last_interaction_at: Time.now)
					connect_user(@user)
					send_data("User created. Welcome!\n")
				else
					send_data("Create requires a name and password.\n")
				end
				return
			end

			if command.downcase.start_with? 'connect' or command.downcase.start_with? 'con'
				if command.split(' ').size == 3
					@user = Thing.where(name: command.split(' ')[1], password: command.split(' ')[2]).first
					if @user
						connect_user(@user)
						send_data("Welcome back #{@user.name}!\n")
					else
						send_data("Name or password incorrect!\n")
					end
				else
					send_data("Connect requires a name and password.\n")
				end
				return
			end

			return



		else

			@user.last_interaction_at = Time.now
			@user.save


			# General commands

			puts "--+ Command received: #{command}"

			return if command == nil || command == ''


			for c in COMMANDS
				# puts "Checking: #{c}"
				if c.should_respond?(command)
					puts "  + Command responding: #{c.name}"
					result = c.execute(@user, command)
					if result
						send_data(result)
					end
					return
				end
			end




		end



		# Check for exits

		destination = nil
		for thing in @user.location.things.where(kind: 'exit')
			if thing.name.downcase == command.downcase
				destination = thing.destination
				break
			end

			if thing.name.include? '<'
				name = thing.name.split('<')[0].strip.downcase
				if command.downcase == name
					destination = thing.destination
					break
				end
			end

			if thing.name.include? '<' and thing.name.include? '>'

				shortcut = thing.name.split('<')[1].split('>')[0].downcase
				if command.downcase == shortcut
					destination = thing.destination
					break
				end
			end
		end

		if destination
			send_data("You enter #{thing.name}.\n")
			@user.location.broadcast(CONNECTIONS, @user, "#{@user.name} exited to #{thing.name}\n")
			destination.broadcast(CONNECTIONS, @user, "#{@user.name} entered from #{@user.location.name}\n")
			@user.location = thing.destination
			@user.save
      for c in COMMANDS
				if c.name == 'look'
					result = c.execute(@user, "look")
					if result
						send_data(result)
					end
					break
				end
			end
      return
		end

		send_data("What was that, #{@user.name}?\n")

	end

	def receive_data data
		parse_command(data)
		#send_data ">>>you sent: #{data}"
		#close_connection if data =~ /quit/i
	end

	def unbind

		puts "--+ Connection closed"
    if @user
  		@user.connected = false
  		@user.save
  		CONNECTIONS.delete(@user.id)
  		@user.location.broadcast(CONNECTIONS, @user, "#{@user.name} has disconnected.\n")
  		puts "--+ #{@user.name} logged out"
    end
	end
end


# Note that this will block current thread.
EventMachine.run {
	puts "--+ Started!"
	EventMachine.start_server "127.0.0.1", 8081, MushServer
}
