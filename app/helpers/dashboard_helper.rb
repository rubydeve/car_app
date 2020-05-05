module DashboardHelper

	def earn(car)
		agreement = car.agreements.where("start_date >= ? AND end_date <= ?", Time.now.beginning_of_month, Time.now.end_of_month)
		earn = []
		agreement.each do |agr|

			if agr.is_paid == "paid"
				earn.push(agr.price)
			else 

			end
		end 
		earn = earn.reject(&:blank?)
		return earn.inject(&:+)
	end

	def cost(car)
		expenses = car.expenses.where(datetime: Time.now.beginning_of_month..Time.now.end_of_month)
		cost = []
		expenses.each do |exp|
			cost.push(exp.price)
		end 
		cost = cost.reject(&:blank?)
		return cost.inject(&:+)
	end 


	def profit(car)
		total_earn = earn(car)
		total_cost = cost(car)
		earn = !total_earn.blank? ? total_earn : 0
		cost = !total_cost.blank? ? total_cost : 0
		profit = earn - cost 

		return profit
	end


	def unpaid(car)
		agreement = car.agreements.where("start_date >= ? AND end_date <= ?", Time.now.beginning_of_month , Time.now.end_of_month)
		unpaid = []
		agreement.each do |agr|

			if agr.is_paid == "unpaid"
				unpaid.push(agr.price)
			else 

			end
		end 
		unpaid = unpaid.reject(&:blank?)
		return unpaid.inject(&:+)

	end


end
