module ReportsHelper

	def total_expense(car, from, to)
		expenses = car.expenses.where(datetime: from.to_time.beginning_of_day..to.to_time.end_of_day)
		cost = []
		expenses.each do |exp|
			cost.push(exp.price)
		end 
		cost = cost.reject(&:blank?)
		return cost.inject(&:+)
	end

	def total_agreement(car, from, to)
	    agreements = car.agreements.where("start_date >= ? AND end_date <= ?", from.to_time.beginning_of_day , to.to_time.end_of_day)
		earn = []
		agreements.each do |agr|
			if agr.is_paid == "paid"
				earn.push(agr.price)
			else 

			end
		end 
		earn = earn.reject(&:blank?)
		return earn.inject(&:+)
	end
	def total_profit(car, from, to)
		total_earn = total_agreement(car, from, to)
		total_cost = total_expense(car, from, to)
		earn = !total_earn.blank? ? total_earn : 0
		cost = !total_cost.blank? ? total_cost : 0
		profit = earn - cost 
		return profit
	end

end
