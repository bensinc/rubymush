require_relative 'command'
class Help < Command


	def initialize
		@name = "help"
		@parameter_count = 0

		@prefixes = ['help']
		@shortcut = '?'

		@help = "help - Shows help index"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size == 1
			commands = ""
			for c in COMMANDS
				commands << c.name.downcase << "\n"
			end
			return("RubyMush Help\n\n#{commands}\nFor more information type: help <command name>\n")
		else
			for c in COMMANDS
				if c.should_respond? @parts[1..-1].join(' ')
					return c.help + "\n"
				end
			end
		end

	end

	def name
		return @name
	end

end
