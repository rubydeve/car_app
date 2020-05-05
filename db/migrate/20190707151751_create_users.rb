class CreateUsers < ActiveRecord::Migration[5.2]
	def change
		create_table :users do |t|
			t.string :first_name
			t.string :last_name
			t.integer :driver_id
			t.string :phone_number
			t.string :address
			t.integer :car_id
			t.timestamps
		end
	end
end
