require_relative 'command'
class Describe < Command

	def initialize
		@name = "describe"

		@prefixes = ['describe', 'desc']
		@shortcut = nil

		@help = "describe <ref>=<description> - Sets the description of an object"
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
			if t
				if t.user_can_edit?(thing)
					t.description = @parts[1..-1].join('=').strip
					t.save
					return("Description set for #{t.name_ref}.\n")
				else
					return("Permission denied.\n")
				end
			else
				return("Object not found.\n")
			end

		else
			return("Usage: description <object name or ref>=<description>")
		end	
	end

	def name
		return @name
	end

end
