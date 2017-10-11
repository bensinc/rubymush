require_relative 'command'
class GetValue < Command

	def initialize
		@name = "read"

		@prefixes = ['read']
		@shortcut = nil

		@help = "read <ref>:<name> - Get an attribute value on an object"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size >= 2
			ref = command.split(' ')[1..-1].join(' ').split(':')[0]
			name = command.split(' ')[1..-1].join(' ').split(':')[1].split('=')[0]
			value = command.split(' ')[1..-1].join(' ').split(':')[1].split('=')[1..-1].join('=')
			t = find_thing(thing, ref)

			if t
				if t.user_can_edit?(thing)
					t.get(name)
					t.save
					return("Value: #{t.name_ref}:#{name} = #{t.get(name)}.\n")
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
