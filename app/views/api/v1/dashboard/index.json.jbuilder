json.success true
json.sort_array @sort_array.each do |sort|  

	if sort.class.name == "Expense"
		json.expenses do 
			json.id sort.id
			json.name sort.name
			json.date sort.datetime.to_s.split('UTC')[0]
			json.price sort.price
		end 
	else

		json.agreements do 
			json.start_date sort.start_date.to_s.split('UTC')[0]
			json.end_date  sort.end_date.to_s.split('UTC')[0] 
			json.first_name sort.first_name 
			json.last_name  sort.last_name 
			if sort.is_paid == "unpaid" 
				json.is_paid "UNPAID"
			elsif sort.is_paid == "paid"
				json.is_paid "PAID"
			else
				json.is_paid "VOID"
			end
		end
	end
end

json.paginate will_paginate @total