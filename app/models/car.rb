class Car < ApplicationRecord

	has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }, default_url: "/assets/unknown.jpg"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	
	
	belongs_to :user

	has_many :agreements
	has_many :expenses

	def driver 
		user = User.find_by_car_id(self.id)
		return user
	end
end
