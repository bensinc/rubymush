require_relative 'command'
class ResetKey < Command

	def initialize
		@name = "resetkey"

		@prefixes = ['resetkey']
		@shortcut = nil

		@help = "resetkey <ref> - Generates a new external key for <ref>"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size > 1
			t = find_thing(thing, @parts[1..-1].join(' '))
			if t
				if t.user_can_edit?(thing)
					t.reset_key
					t.save
					return("Return new key for #{t.name_ref}: #{t.external_key}\n")
				else
					return("Permission denied!\n")
				end
			else
				return("Object not found.\n")
			end
		else
			return("Object not found.\n")
		end
	end

	def name
		return @name
	end

end
