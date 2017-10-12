require_relative 'command'
class Give < Command

	def initialize
		@name = "give"

		@prefixes = ['give']
		@shortcut = nil

		@help = "give <ref1>=<ref2> - Moves <ref1> from your inventory to <ref2>'s inventory'"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size >= 2
			@parts.shift
			@parts = @parts.join(' ').split('=')
			t = find_thing(thing, @parts[0])
			dest = find_thing(thing, @parts[1])

			if t
				if t.location == thing
					if dest
						t.location = dest
						t.save
						dest.receive_raw_message(thing, "#{thing.name}".colorize(:light_cyan) + " gave you #{t.name}.")
						return("You gave #{t.name} to #{dest.name}.\n")
					else
						return("Destination not found.\n")
					end
				else
					return("Object not in your inventory.\n")
				end
			else
				return("Object not found.\n")
			end

		else
			return("Usage: description <object name or ref>=<description>\n")
		end
	end

	def name
		return @name
	end

end
