json.success true
json.expenses @expenses.each do |expense|  
	json.id expense.id
	json.name expense.name
	json.date expense.datetime.to_s.split('UTC')[0]
    json.price expense.price
end

json.paginate will_paginate @expenses,renderer: WillPaginate::ActionView::BootstrapLinkRenderer 


