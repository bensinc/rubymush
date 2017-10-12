class Broadcaster
	def initialize(thing, connections)
		@thing = thing
		@connections = connections
	end
	def broadcast_location(message)
		if @thing.location
			@thing.location.broadcast(CONNECTIONS, @thing, message)
		else
			@thing.broadcast(CONNECTIONS, @thing, message)
		end
	end
end
