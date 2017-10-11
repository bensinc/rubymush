require 'httparty'

class MushInterface
	def initialize(thing)
		@thing = thing
	end

	def is_number?(obj)
			obj.to_s == obj.to_i.to_s
	end


	def find(q)
			q = "#{q}"
			q.strip!
			# puts "--+ Finding thing: #{q}"
			if is_number?(q)
				return Thing.where(id: q).first
			elsif q.downcase == 'here'
				return thing.location
			elsif q.downcase == 'me'
				return @thing
			else
				return Thing.where(["name like ? and location_id in (?)", "#{q}%", [@thing.id, @thing.location_id]]).first
			end
	end

	def fetch(url)
		response = HTTParty.get(url)
		# puts "Response"
		# puts response
		json = JSON.parse(response.body)
		# puts json
		return json
	end
end
