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
			if t and (thing.wizard? or t.owner == thing)
				t.reload
				back = t.name_ref_color.colorize(:light_magenta) + "\n"
				back += " kind: #{t.kind}\n"
				if t.wizard?
					back += " wizard\n".colorize(:red)
				end
				back += " created: #{t.created_at}\n"
				back += " description: #{t.description}\n"

				if t.owner
					back += " owner: #{t.owner.name_ref_color}\n"
				else
					back += " owner: none\n"
				end

				if t.location
					back += " location: #{t.location.name_ref_color}\n"
				else
					back += " location: none\n"
				end

				if t.destination
					back += " destination: #{t.destination.name_ref_color}\n"
				end

				if t.external_key
					back += " external key: #{t.external_key}\n"
				end


				if t.things.size > 0
					back += "Contents:\n".colorize(:light_blue)
					for o in t.things.where("kind != 'exit'")
						back += " #{o.name_ref_color}\n"
					end
				end

				exits = Thing.where(location_id: t.id, kind: 'exit')

				if exits.size > 0

					# puts "Exits: #{exits.size}"
					back += "Exits:\n".colorize(:light_blue)
					list = ""
					for ex in exits
						# puts "#{ex.name}, #{ex.id}, #{ex.location_id}"
						list += " " + ex.name_ref_color + "\n"
					end

					back += "#{list.chop}\n"

				end

				if t.codes.size > 0 # && t.owner == thing
					back += "Code:\n".colorize(:light_blue)
					for code in t.codes
						back += "\n" if code.include?("\n")
						back += " #{code.name}: #{code.code}\n"
					end
				end

				if t.actions.size > 0 # && t.owner == thing
					back += "Actions:\n".colorize(:light_blue)
					for action in t.actions
						back += " #{action.name}: #{action.code}\n"
					end
				end

				if t.atts.size > 0 # && t.owner == thing
					back += "Attributes:\n".colorize(:light_blue)
					for att in t.atts
						back += " #{att.name}: #{att.value}\n"
					end
				end


				return(back)

			elsif t
				t.reload
				back = t.name_ref_color.colorize(:light_magenta) + "\n"
				if t.wizard?
					back += " wizard\n".colorize(:red)
				end
				back += " description: #{t.description}\n"
				back += " created: #{t.created_at}\n"

				if t.owner
					back += " owner: #{t.owner.name_ref_color}\n"
				else
					back += " owner: none\n"
				end

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
