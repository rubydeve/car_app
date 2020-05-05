class Api::V1::DashboardController < ApplicationController

	before_action :get_agreement

	def index 
		@from  =  Time.now.beginning_of_month
		@to = Time.now.end_of_month 
		@agreements = @car.agreements.where("start_date >= ? AND end_date <= ?", @from , @to).paginate(page: params[:page])
		@expenses = @car.expenses.where(datetime: @from..@to)
		@total = @agreements + @expenses
		@total = @total.paginate(:page => params[:page], :per_page => 10)
		@sort_array = @total.sort_by{|e| e.class.name == "Expense" ? e[:datetime] : e[:start_date] }
		
	end

	def earning

	end

	def expense

	end

	def profit

	end

	def unpaid_agreement

	end

	def agreement_this_month
		@agreement = @car.agreements.where("start_date >= ? AND end_date <= ?", Time.now.beginning_of_month, Time.now.end_of_month ).paginate(page: params[:page])
	end

	def expense_this_month
		@agreement = @car.expenses.where(datetime: Time.now.beginning_of_month..Time.now.end_of_month).paginate(page: params[:page])
	end

	private 

	def get_agreement
		@car = Car.find_by_id(params[:car_id])
	end
end
