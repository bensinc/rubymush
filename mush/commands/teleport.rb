require_relative 'command'
class Teleport < Command

	def initialize
		@name = "teleport"

		@prefixes = ['tel', 'tp', 'teleport']
		@shortcut = nil

		@help = "teleport <ref> - Teleports yourself to <ref>\nteleport <ref1>=<ref2> - Teleports <ref1> to <ref2>\n"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if command.include?('=')
			t = find_thing(thing, command.split('=')[0].split(' ')[1..-1].join(' '))
			dest = find_thing(thing, command.split('=')[1].strip)
			return("Target not found!\n") unless t
			return("Destination not found!\n") unless dest
			# puts "tp #{t.name} to #{dest.name}"
			# puts "thing: #{thing.name}"
			if thing.wizard? or t.location.owner == thing or t.location == thing
				t.location.broadcast(CONNECTIONS, thing, "#{thing.name} has left.\n")
				t.location = dest
				t.save
				t.location.broadcast(CONNECTIONS, thing, "#{thing.name} has arrived.\n")
				t.receive_raw_message(thing, "#{thing.name} teleported you to #{dest.name}.")
				t.receive_raw_message(thing, t.cmd("look"))
				dest.entered(t)
				return("Teleported #{t.name} to #{dest.name}.\n")
			else
				return("Permission denied!\n")
			end
		else
			if @parts.size == 2
				t = Thing.where(id: @parts[1]).first
				if t
					thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} has left.\n")
					thing.location = t
					thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} has arrived.\n")
					thing.save
					thing.cmd("look")
					thing.receive_raw_message(thing, thing.cmd("look"))
					dest.entered(thing)

					return("Teleported to #{t.name_ref}.\n")
				else
					return("Teleport location not found!\n")
				end
			else
				return("Teleport request an object number.\n")
			end
		end

	end

	def name
		return @name
	end

end
