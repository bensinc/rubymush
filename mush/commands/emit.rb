require_relative 'command'
require_relative '../lib/broadcaster.rb'
class Emit < Command

	def initialize
		@name = "emit"
		@parameter_count = 1

		@prefixes = ['emit']
		@shortcut = nil

		@help = "emit <message> - Emits message by itself in current location"
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
		b.broadcast_location("#{message}\n")
		return("#{message}\n")
	end

	def name
		return @name
	end

end
