class Action < ActiveRecord::Base
	belongs_to :thing
	def execute(command)
		puts "--+ Running action: #{action.name} on #{action.thing.name_ref}"
		code = self.thing.codes.where(name: self.code).first
		if code
			begin
				self.action.thing.execute(self.code, command.split(' ')[1..-1].join(' '))
				return(nil)
			rescue Exception => e
				return("Error: #{e}\n")
			end
		else
			return("Code #{name} not found on #{self.action.thing.name_ref}!\n")
		end
	end
end
