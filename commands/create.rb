require_relative 'command'
class Create < Command

	def initialize
		@name = "create"

		@prefixes = ['create']
		@shortcut = nil

		@help = "create <name> - Creates a new object and places it in your inventory"
	end

	def execute(thing, command)
		@parts = command.split(' ')
		return(process(thing, command))
	end

	def process(thing, command)
		new_thing = Thing.create(location_id: thing.id, owner_id: thing.id, kind: 'object', name: command.split(' ')[1..-1].join(' '), created_at: Time.now)
		return("Object created: #{new_thing.name} (##{new_thing.id})\n")
	end

	def name
		return @name
	end

end
