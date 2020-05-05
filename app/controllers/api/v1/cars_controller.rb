class Api::V1::CarsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@user = User.find_by_id(params[:user_id])
		@cars = @user.cars
	end

	def create 
		if params[:car] && params[:driver] && params[:user_id]
			@car = Car.new(param_car)
			@car.user_id = params[:user_id]

			if @car.save
				if save_driver(@car)

				else
					render :json=> {
						:error => "Car did not created. Please try again later."
					},:status => 400
				end
			else
				render :json=> {
					:error => "Car did not created. Please try again later."
				},:status => 400
			end

		else
			if params[:user_id].blank?
				render :json=> {
					:error => "User Not Login. Login First."
				},:status => 400
			else
				render :json=> {
					:error => "Car did not created. Please try again later."
				},:status => 400
			end
		end

	end 

	def update 
		@car = Car.find_by_id(params[:id])
		if @car.update(param_car)

		else
			render :json=> {
				:error => "Car did not update. Please try again later."
			},:status => 400

		end
	end

	def destroy 
		@car = Car.find_by_id(params[:id])
		if @car.blank?
			render :json=> {
				:error => "Car did not find. Please try again later."
			},:status => 400
		else

			if @car.destroy
				render :json=> {
					:success => "Car Destroy."
				},:status => 200
			else
				render :json=> {
					:error => "Car did not Destroy. Please try again later."
				},:status => 400
			end
		end

	end

	private

	def param_car
		params.require(:car).permit(:model,:color,:transmission,:fuel_type,:name,:user_id,:avatar)
	end

	def new_params
		params.require(:driver).permit(:first_name, :last_name, :address, :phone_number, :email, :password)
	end

	def process_avatar
		if params[:account] && params[:account][:avatar]
			data = StringIO.new(Base64.decode64(params[:account][:avatar][:data]))
			data.class.class_eval { attr_accessor :original_filename, :content_type }
			data.original_filename = params[:account][:avatar][:filename]
			data.content_type = params[:account][:avatar][:content_type]
			params[:account][:avatar] = data
		end
	end

	def save_driver(car)
		@already = User.find_by_email(params[:driver][:email])
		@user =  User.new(new_params)
		@user.car_id = car.id
		@user.driver_id = params[:user_id]
		
		if @already.blank?
			if @user.save
				@user.add_role :driver
				is_save = true
			else
				is_save = false
			end
		else 
			is_save = false
		end
		return is_save
	end
end
