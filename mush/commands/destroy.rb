require_relative 'command'
class Destroy < Command

	def initialize
		@name = "destroy"

		@prefixes = ['destroy', 'dest']
		@shortcut = nil

		@help = "destroy <ref> - Destroys an object"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size == 2
			t = find_thing(thing, @parts[1..-1].join(' '))
			if t
				if t.user_can_edit?(thing) and t != thing
					t.destroy
					return("#{t.name_ref} destroyed!\n")
				else
					return("Permission denied.\n")
				end
			else
				return("Object not found!\n")
			end
		else
			return("Destroy requires an object number.\n")
		end
	end

	def name
		return @name
	end

end
