class Expense < ApplicationRecord
	self.per_page = 1
	belongs_to :car

end
