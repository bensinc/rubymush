require_relative 'command'
class Chown < Command

	def initialize
		@name = "chown"

		@prefixes = ['chown']
		@shortcut = nil

		@help = "chown <ref1>=<ref2> - Sets <ref2> as owner of <ref1>"
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
				if t.user_can_edit?(thing)
					if dest
						t.owner = dest
						t.save
						# dest.receive_raw_message(thing, "#{thing.name}".colorize(:light_cyan) + " gave you #{t.name}.")
						return("Ownership of #{t.name} changed to #{dest.name}.\n")
					else
						return("New owner not found.\n")
					end
				else
					return("Permission denied.\n")
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
