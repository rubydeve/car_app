class Api::V1::ReportsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :get_car
	
	def index 
		if @car.blank?
			render :json=> {
				:error => "No Car find."
			},:status => 400
		else

			if !params[:report].blank?
				@from = params[:report][:date_from].to_time.beginning_of_day
				@to = params[:report][:date_to].to_time.end_of_day
			else
				@from = Time.now.beginning_of_month
				@to = Time.now.end_of_month
			end
			@agreements = @car.agreements.where("start_date >= ? AND end_date <= ?", @from , @to).paginate(page: params[:page])
			@expenses = @car.expenses.where(datetime: @from..@to)
			@total = @agreements + @expenses
			@total = @total.paginate(:page => params[:page], :per_page => 10)
			@sort_array = @total.sort_by{|e| e.class.name == "Expense" ? e[:datetime] : e[:start_date] }
		end
	end 

	private 

	def get_car
		@car = Car.find_by_id(params[:car_id])
	end
end
