class ReportsController < ApplicationController
	
	before_action :check_user 
	before_action :get_car
	
	def index 
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

	private 

	def get_car
		@car = Car.find_by_id(session[:car_id])
	end
	def check_user
		if current_user and current_user.roles.first.try(:name) == "owner"
			
		elsif 
			redirect_to dashboard_index_url
		else
			redirect_to root_url
		end
	end

end
