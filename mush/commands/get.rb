require_relative 'command'
class Get < Command

	def initialize
		@name = "get"

		@prefixes = ['get', 'take']
		@shortcut = nil

		@help = "get <ref> - Picks up an item and adds it to your inventory"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size > 1
			t = find_thing(thing, @parts[1..-1].join(' '))
			if t and t.location == thing.location and t.kind != 'player'
				t.location_id = thing.id
				t.save
				t.reload
				return("You pick up #{t.name_ref}\n")
				thing.location.broadcast(CONNECTIONS, thing, "#{thing.name} picked up #{t.name}.\n")
			else
				return("I don't see that here!\n")
			end
		else
			return("What do you want to drop?\n")
		end
	end

	def name
		return @name
	end

end
