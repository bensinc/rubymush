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
				return SafeThing.new(Thing.where(id: q).first)
			elsif q.downcase == 'here'
				return SafeThing.new(thing.location)
			elsif q.downcase == 'me'
				return SafeThing.new(@thing)
			else
				return SafeThing.new(Thing.where(["name like ? and location_id in (?)", "#{q}%", [@thing.id, @thing.location_id]]).first)
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

	def execute(q, code, params)
		# puts "EXECUTE: #{q}, #{code}, #{params}"
		t = find(q)
		if t and (t == @thing or t.owner == @thing)
			t.execute(code, params)
		end
	end



end
