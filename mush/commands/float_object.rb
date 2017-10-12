require_relative 'command'
class FloatObject < Command

	def initialize
		@name = "float"

		@prefixes = ['float']
		@shortcut = nil

		@help = "float <ref> - Clears the location of <ref>. Use this to turn objects into rooms."
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size > 1
			t = find_thing(thing, @parts[1..-1].join(' '))
			if t and t.user_can_edit?(thing) and t.kind != 'player'
				t.location_id = nil
				t.save
				t.reload
				return("#{t.name_ref} floated. Use 'floating' to list your floating objects.\n")
			else
				return("I don't see that here!\n")
			end
		else
			return("What do you want to float?\n")
		end
	end

	def name
		return @name
	end

end
