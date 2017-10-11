class Thing < ActiveRecord::Base
	belongs_to :owner, foreign_key: 'owner_id', class_name: 'Thing'
	belongs_to :location, foreign_key: 'location_id', class_name: 'Thing'
	belongs_to :destination, foreign_key: 'destination_id', class_name: 'Thing'
	has_many :things, foreign_key: 'location_id'
	def name_ref
		return "#{self.name} (#{self.id})"
	end

	def user_can_edit?(user)
		return self == user || self.owner == user
	end

	def broadcast(connections, user, message)
		for thing in self.things.where(kind: 'player', connected: true)
			em = connections[thing.id]
			if em and em.get_user != user
				# puts "--+ Broadcasting to: #{em}"
				em.send_data(message)
			end
		end
	end

end
