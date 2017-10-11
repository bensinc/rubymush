require_relative 'command'
class Emote < Command

	def initialize
		@name = "Emote"
		@parameter_count = 1

		@prefixes = [':', 'emote']
		@shortcut = ':'

		@help = ":<message> - Emotes in your current location"
	end

	def execute(thing, command)
		# check_parts(command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		message = @parts[1..-1].join(' ')
		message = command[1..-1] if command.start_with?(':')
		thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} #{message}\n")
		return("#{thing.name} #{message}\n")
	end

	def name
		return @name
	end

end
