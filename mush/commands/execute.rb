require_relative 'command'
class Execute < Command

	def initialize
		@name = "execute"

		@prefixes = ['execute', 'exe']
		@shortcut = nil

		@help = "execute <ref>:<name> - Executes code <name> on <ref>\nexecute <ref>:<name>=<params> - Executes code <name> on <ref> with <params>"
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
			params = nil
			if name.include? '='
				params = name.split('=')[1].strip
				name = name.split('=')[0].strip
			end
			t = find_thing(thing, ref)
			if t
				if t.owner == thing.owner or t == thing or t.owner == thing
					code = t.codes.where(name: name).first
					if code
						begin
							t.execute(thing, name, params)
							return(nil)
						rescue Exception => e
							return("Error: #{e}\n")
							puts("Error: #{e}\n#{e.backtrace}\n")
						end
					else
						return("Code #{name} not found on #{t.name_ref}!\n")
					end
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
