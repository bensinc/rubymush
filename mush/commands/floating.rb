require_relative 'command'
class Floating < Command


	def initialize
		@name = "floating"

		@prefixes = ['floating']
		@shortcut = nil

		@help = "floating - Lists your floating objects."
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		things = Thing.where(["owner_id = ? and location_id is null", thing.id])
		back = ""
		if things.size > 0
			for t in things
				back << "#{t.name_ref}\n"
			end
			return back
		else
			return "No floating objects found.\n"
		end
	end

	def name
		return @name
	end

end
