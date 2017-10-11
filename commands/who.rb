require_relative 'command'
class Who < Command


	def initialize
		@name = "who"

		@prefixes = ['who']
		@shortcut = nil

		@help = "who - Lists currently connected players"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		back = "Name\t\tIdle\t\tDoing\n".colorize(:bold)
		for player in Thing.where('connected is true')
			back << "#{player.name}\t\t#{time_ago_in_words(player.last_interaction_at)}\t\t#{player.doing}\n"
		end
		return(back)
	end

	def name
		return @name
	end

end
