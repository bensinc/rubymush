class Code < ActiveRecord::Base
	belongs_to :thing

	def execute(params)
		# puts "--+ Running code: #{self.name} on #{self.thing.name_ref}"		
			begin
				self.action.thing.execute(self.code, params)
				return(nil)
			rescue Exception => e
				return("Error: #{e}\n")
			end
	end
end
