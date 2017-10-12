require_relative 'command'
class Inventory < Command


	def initialize
		@name = "inventory"

		@prefixes = ['i', 'inv', 'inventory']
		@shortcut = nil

		@help = "inventory - Shows your inventory."
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		things = Thing.where(location: thing.id).order('name asc')
		back = "You are carrying:\n".colorize(:light_magenta)
		if things.size == 0
			back += "Nothing!\n"
		end
		for t in things
				back += "#{t.name_ref_color}\n"
		end
		return(back)
	end

	def name
		return @name
	end

end
