class Command

	def initialize
		@name = ""
		@parameter_count = 0
		@prefixes = []
		@shortcut = nil
		@help = ""
		@broadcaster = nil
	end

	def should_respond?(c)
		# puts "Should respond? #{c}"
		parts = c.split(' ')
		prefixes.include?(parts[0].downcase) || (shortcut && c.start_with?(shortcut))
	end

	def help
		return @help
	end

	def prefixes
		return @prefixes
	end

	def shortcut
		return @shortcut
	end

	def time_ago_in_words(t)
		seconds = Time.now.to_i - t.to_i
		if seconds > 86400
			return "#{seconds/86400}d"
		end
		if seconds > 3600
			return "#{seconds/3600}h"
		end
		if seconds > 60
			return "#{seconds/60}m"
		end
		return "#{seconds}s"
	end


	def is_number?(obj)
			obj.to_s == obj.to_i.to_s
	end

	def find_thing(thing, q)
    return unless q
		q.strip!
		# puts "--+ Finding thing: #{q}"
		if is_number?(q)
			return Thing.where(id: q).first
		elsif q.downcase == 'here'
			return thing.location
		elsif q.downcase == 'me'
			return thing
		else
			return Thing.where(["name like ? and location_id in (?)", "#{q}%", [thing.id, thing.location_id]]).first
		end
	end

	def format(text)
		text.gsub('\\n', "\n").gsub('\\t', "\t")
	end


end
