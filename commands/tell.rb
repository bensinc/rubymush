require_relative 'command'
class Tell < Command

	def initialize
		@name = "tell"

		@prefixes = ['tell']
		@shortcut = nil

		@help = "tell <ref>=<message> - Privately sends <message> to <ref>"
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
				message = @parts[1..-1].join('=').strip
				t.receive_message(thing, message)
				return("Told #{t.name}: #{message}.\n")
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
