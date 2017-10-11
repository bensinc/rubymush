require_relative 'command'
class Examine < Command

	def initialize
		@name = "examine"

		@prefixes = ['examine', 'ex']
		@shortcut = nil

		@help = "examine <ref> - Shows object details"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		if @parts.size > 1
			t = find_thing(thing, @parts[1..-1].join(' '))
			if t
					back = t.name_ref << "\n"
					back << " kind: #{t.kind}\n"
					back << " created: #{t.created_at}\n"
					back << " description: #{t.description}\n"

					if t.owner
						back << " owner: #{t.owner.name_ref}\n"
					else
						back << " owner: none\n"
					end

					if t.location
						back << " location: #{t.location.name_ref}\n"
					else
						back << " location: none\n"
					end

					if t.destination
						back << " destination: #{t.destination.name_ref}\n"
					end


					if t.things.size > 0
						back << "Contents:\n"
						for o in t.things
							back << " #{o.name_ref}\n"
						end
					end

					exits = Thing.where(location_id: t.id, kind: 'exit')

					if exits.size > 0

						# puts "Exits: #{exits.size}"
						back << "Exits:\n"
						list = ""
						for ex in exits
							# puts "#{ex.name}, #{ex.id}, #{ex.location_id}"
							list << " " << ex.name_ref << "\n"
						end

						back << "#{list.chop}\n"
					end


					return(back)
			else
				return("I don't see that here!\n")
			end
		else
			return("What do you want to examine?\n")
		end
	end

	def name
		return @name
	end

end
