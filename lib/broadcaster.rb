class Broadcaster
	def initialize(thing, connections)
		@thing = thing
		@connections = connections
	end
	def broadcast_location(message)
		@thing.location.broadcast(CONNECTIONS, @thing, message)
	end
end
