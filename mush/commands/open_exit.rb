require_relative 'command'
class OpenExit < Command

	def initialize
		@name = "open"

		@prefixes = ['open']
		@shortcut = nil

		@help = "open <name>=<ref> - Opens an exit named <name>, that leads to <ref>"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size > 1
			name = @parts[1..-1].join(' ').split('=')[0].strip
			destination = @parts[1..-1].join(' ').split('=')[1].strip
			destination_room = find_thing(thing, destination)
			if destination_room
				Thing.create(name: name, owner_id: thing.id, location_id: thing.location_id, kind: 'exit', destination_id: destination_room.id)
				return "Exit opened: #{name}\n"
			else
				return "Destination not found!\n"
			end
		else
			return "Usage: open name <shortcut> = #ref\n"
		end

	end

	def name
		return @name
	end

end
