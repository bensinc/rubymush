require_relative 'command'
class SetCode < Command

	def initialize
		@name = "code"

		@prefixes = ['code']
		@shortcut = nil

		@help = "code <ref>:<name>=<javascript code> - Sets code on an object"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size >= 2
			ref = command.split(' ')[1..-1].join(' ').split(':')[0]
			name = command.split(' ')[1..-1].join(' ').split(':')[1].split('=')[0]
			code = command.split('=')[1..-1].join('=')
			t = find_thing(thing, ref)



			if t
				if t.user_can_edit?(thing)
					t.set_code(name, code)
					t.save
					return("Code set for #{t.name_ref}:#{name}.\n")
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
