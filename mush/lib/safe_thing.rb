class SafeThing
	def initialize(thing)
		@thing = thing
	end

	def id
		@thing.id
	end

	def name
		@thing.name
	end

	def location_ref
		@thing.location_id
	end

	def owner_ref
		@thing.owner_id
	end

	def description
		@thing.description
	end

	def set(name, value)
		@thing.set(name, value)
	end

	def get(name)
		@thing.get(name)
	end

	def name_ref
		@thing.name_ref
	end

	def cmd(command)
		@thing.cmd(command)
	end

	def id=(new_id)
	end

	def contents
		@thing.things
	end

	def action(name, params)
		puts "ACTION: #{name}, #{params}"
		if @thing.kind == 'object'
			action = @thing.actions.where(name: name).first
			if !action and @thing.location and @thing.location.kind == 'object'
				action = @thing.location.actions.where(name: name).first
			end
			if !action and @thing.location and @thing.location.kind == 'object'
				for o in @thing.location.things.where(kind: 'object')
					action = o.actions.where(name: name).first
					break if action
				end
			end
			puts "Found action: #{action.thing.name_ref}, #{action.name}, #{action.code}"
			if action
				action.thing.execute(self, action.code, params)
			end
		end
	end


end
