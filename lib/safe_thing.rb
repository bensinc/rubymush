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
end
