class CreateExpenses < ActiveRecord::Migration[5.2]
	def change
		create_table :expenses do |t|
			t.string :name
			t.datetime :datetime
			t.integer :car_id
			t.decimal :price
			t.timestamps
		end
	end
end
