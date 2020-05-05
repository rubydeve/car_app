class CreateAgreements < ActiveRecord::Migration[5.2]
	def change
		create_table :agreements do |t|
			t.string :first_name
			t.string :last_name
			t.string :phone_number
			t.datetime :start_date
			t.datetime :end_date
			t.integer :car_id
			t.string :is_paid
			t.boolean :is_current 
			t.decimal :price
			t.timestamps
		end
	end
end
