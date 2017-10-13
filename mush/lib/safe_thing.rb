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
		# puts "ACTION: #{name}, #{params}"
		if @thing.kind == 'object'
			action = @thing.actions.where(name: name).first
			if action
				code = @thing.codes.where(name: action.code).first
				@thing.execute(self, code.name, params)
			end
		end
	end


end
