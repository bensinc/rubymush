require_relative 'command'
require_relative '../lib/broadcaster.rb'
class Say < Command

	def initialize
		@name = "Say"
		@parameter_count = 1

		@prefixes = ['"', 'say', 's']
		@shortcut = '"'

		@help = "say <message> - Speaks in your current location"
	end

	def execute(thing, command)
		# check_parts(command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		message = @parts[1..-1].join(' ')
		message = command[1..-1] if command.start_with?('"')
		b = Broadcaster.new(thing, CONNECTIONS)
		b.broadcast_location("#{thing.name} says, ".colorize(:light_blue) +"\"#{message}\"\n")
		# thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} says, \"#{message}\"\n")
		return("You said, ".colorize(:light_blue) +  "\"#{message}\"\n")
	end

	def name
		return @name
	end

end
