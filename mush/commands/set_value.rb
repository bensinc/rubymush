require_relative 'command'
class SetValue < Command

	def initialize
		@name = "set"

		@prefixes = ['set']
		@shortcut = nil

		@help = "set <ref>:<name>=<value> - Sets an attribute value on an object"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size >= 2
			ref = command.split(' ')[1..-1].join(' ').split(':')[0]
			name = command.split(' ')[1..-1].join(' ').split(':')[1].split('=')[0].strip
			value = command.split(' ')[1..-1].join(' ').split(':')[1].split('=')[1..-1].join('=')
			t = find_thing(thing, ref)

			if t
				if t.user_can_edit?(thing)
					t.set(name, value)
					t.save
					return("Value set: #{t.name_ref}:#{name} = #{value}.\n")
				else
					return("Permission denied.\n")
				end
			else
				return("Object not found.\n")
			end

		else
			return("Usage: #{@help}\n")
		end
	end

	def name
		return @name
	end

end
