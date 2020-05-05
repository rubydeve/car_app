class CreateCars < ActiveRecord::Migration[5.2]
	def change
		create_table :cars do |t|
			t.string :model
			t.string :color
			t.string :transmission
			t.string :fuel_type
			t.string :name 
			t.integer :user_id
			t.timestamps
		end
	end
end
