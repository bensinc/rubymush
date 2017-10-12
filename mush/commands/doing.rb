require_relative 'command'
class Doing < Command

	def initialize
		@name = "doing"

		@prefixes = ['doing', '@doing']
		@shortcut = nil

		@help = "doing <message> - Sets your \"doing\" message, as seen in the \"who\" command."
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		message = @parts[1..-1].join(' ')
		thing.doing = message
		thing.save
		return("Doing set: #{message}\n")
	end

	def name
		return @name
	end

end
