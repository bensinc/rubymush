require_relative 'command'
class Execute < Command

	def initialize
		@name = "execute"

		@prefixes = ['execute', 'exe']
		@shortcut = nil

		@help = "execute <ref>:<name> - Executes code <name> on <ref>"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size >= 2 && command.include?(':')
			@parts.shift

			ref = @parts.join(' ').split(':')[0].strip
			name = @parts.join(' ').split(':')[1].strip
			t = find_thing(thing, ref)
			if t
				code = t.codes.where(name: name).first
				if code
					begin
						t.execute(name, nil)
						return(nil)
					rescue Exception => e
						return("Error: #{e}\n")
						# return("Error: #{e}\n#{e.backtrace}\n")
					end
				else
					return("Code #{name} not found on #{t.name_ref}!\n")
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
