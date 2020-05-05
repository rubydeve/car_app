class Api::V1::DriversController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index 
		@car = Car.find_by_id(params[:car_id])
		@user = @car.driver
	end


	def update 
		@car = Car.find_by_id(params[:car_id])
		@user = @car.driver
		@already = User.find_by_email(params[:driver][:email])
		if @already.blank? or params[:driver][:email] == @user.email
			if @user.update(params_driver)
				
			else
				render :json=> {
					:error => "Driver did not update. Please try again later."
				},:status => 400
			end
		else 
			
			render :json=> {
				:error => "Driver Already Exist With this Email."
			},:status => 400
		end

	end


	

	private 

	def params_driver
		params.require(:driver).permit(:first_name, :last_name, :address, :email, :password )
	end

end
