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
				back << t.name_ref + "\n" + t.description + "\n"
			else
				back << "#{t.name_ref}\nYou see nothing special.\n"
			end

			for o in t.things.where(["kind != 'exit' and id != ?", thing.id])
				back << "#{o.name_ref}\n" if o.kind == 'object' || (o.kind == 'player' && o.connected?)
			end

			exits = Thing.where(location_id: t.id, kind: 'exit')

			if exits.size > 0

				# puts "Exits: #{exits.size}"
				back << "Exits:\n"
				list = ""
				for ex in exits
					# puts "#{ex.name}, #{ex.id}, #{ex.location_id}"
					list << ex.name << ", "
				end
				list.chop!.chop!
				back << "#{list}\n"
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
