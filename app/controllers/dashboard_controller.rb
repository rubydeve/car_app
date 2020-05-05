class DashboardController < ApplicationController
	before_action :check_user 

	def index
		@car = Car.find_by_id(session[:car_id])
		@agreement = @car.agreements.where("start_date >= ? AND end_date <= ?", Time.now.beginning_of_month, Time.now.end_of_month ).paginate(page: params[:page])
	end 
	private 
	def check_user
		if current_user
			
		else
			redirect_to root_url
		end
	end
end
