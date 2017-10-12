require_relative 'command'
class Look < Command

	def initialize
		@name = "look"

		@prefixes = ['look', 'l']
		@shortcut = nil

		@help = "look <optional ref> - Shows an object's description and other details"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size == 1
			t = thing.location
		else
			t = find_thing(thing, @parts[1..-1].join(' '))
		end
		if t
			t.reload
			# puts "--+ Look: #{t.name_ref}: #{t.description}"
			back = "\n"
			if t.description
				back += "[ " + t.name.colorize(:light_magenta) + " ]\n" + format(t.description) + "\n"
			else
				back += "[ " + "#{t.name}".colorize(:light_magenta) + " ]\n" + "You see nothing special.\n"
			end

			if t.kind != 'player' && t.location == nil
				if t.things.where(["kind != 'exit' and id != ?", thing.id]).size > 0
					back += "Things here:\n".colorize(:blue)
					for o in t.things.where(["kind != 'exit' and id != ?", thing.id])
						back += " #{o.name}\n".colorize(:light_blue) if o.kind == 'object'
						back += " #{o.name}\n".colorize(:light_green) if o.kind == 'player' && o.connected?
					end
				end

				exits = Thing.where(location_id: t.id, kind: 'exit')

				if exits.size > 0

					# puts "Exits: #{exits.size}"
					back += "Exits:\n".colorize(:cyan)
					list = ""
					for ex in exits
						# puts "#{ex.name}, #{ex.id}, #{ex.location_id}"
						list += ex.name.colorize(:light_cyan) << ", "
					end
					list.chop!.chop!
					back << " #{list}\n"
				end
			end
			return(back)
		else
			return("Object not found!\n")
		end
	end

	def name
		return @name
	end

end
