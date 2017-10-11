require_relative 'command'
class Teleport < Command

	def initialize
		@name = "teleport"

		@prefixes = ['tel', 'tp', 'teleport']
		@shortcut = nil

		@help = "teleport <ref> - Teleports yourself to <ref>"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size == 2
			t = Thing.where(id: @parts[1]).first
			if t
				thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} has left.\n")
				thing.location = t
				thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} has arrived.\n")
				thing.save
				return("Teleported to #{t.name_ref}...\n")
			else
				return("Teleport location not found!\n")
			end
		else
			return("Teleport request an object number.\n")
		end

	end

	def name
		return @name
	end

end
