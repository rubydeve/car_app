json.success true
json.expenses @agreements.each do |agreement| 
	json.start_date agreement.start_date.to_s.split('UTC')[0]
	json.end_date  agreement.end_date.to_s.split('UTC')[0] 
	json.first_name agreement.first_name 
	json.last_name  agreement.last_name 
	if agreement.is_paid == "unpaid" 
		json.is_paid "UNPAID"
	elsif agreement.is_paid == "paid"
		json.is_paid "PAID"
	else
		json.is_paid "VOID"
	end
end

json.paginate will_paginate @agreements