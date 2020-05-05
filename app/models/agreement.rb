class Agreement < ApplicationRecord

	self.per_page = 1

	belongs_to :car

	def fullname
		if  self.try(:first_name)
			if !self.last_name.blank?
				name = self.try(:first_name).capitalize + " " +  self.try(:last_name).capitalize
			else
				name = self.try(:first_name).capitalize
			end
		else
			name = ""
		end
		return name
	end

end
