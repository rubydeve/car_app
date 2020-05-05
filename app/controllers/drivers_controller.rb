class DriversController < ApplicationController
	
	before_action :check_user 
	before_action :get_car , only: [:index , :edit, :update]

	def index 
		@user = @car.driver
	end 

	def new 
		@user = User.new
	end 

	def create 
		begin
			@car = Car.new(:model => session[:car]["model"], :color=> session[:car]["color"],:transmission=> session[:car]["transmission"],:fuel_type=> session[:car]["fuel_type"],:name=> session[:car]["name"],:avatar => File.open(session[:car]["avatar"]))
			@car.user_id = current_user.id
			if @car.save
				if save_user(@car)
					File.delete(session[:car]["avatar"]) if File.exist?(session[:car]["avatar"])
					session.delete(:car)
					flash[:success] = 'Car Successfully Created!' 
					redirect_to cars_url
				else
					@car.destroy
					redirect_to new_car_url
					flash[:error] = 'Car Not Create Try Agian'  
				end
			end

		rescue => e
			redirect_to new_car_url
			flash[:error] = 'Car Not Create Try Agian'  
		end
	end 

	def edit 
		@user = @car.driver
	end 

	def update 
		@user = @car.driver
		@already = User.find_by_email(params[:user][:email])
		if @already.blank? or params[:user][:email] == @user.email
			if @user.update(new_params)
				flash[:success] = 'Driver Successfully Update!' 
				redirect_to drivers_url 
			else
				flash[:error] = "Driver not Create Try Agian"
				render :edit
			end
		else 
			flash[:error] = "Driver Already Exist With this Email"
			render :edit
		end

	end 

	private 

	def params_driver
		params.require(:driver).permit(:first_name, :last_name, :address, :email,:car_id, :password ,:driver_id)
	end
	def new_params
		params.require(:user).permit(:first_name, :last_name, :address, :phone_number, :email, :password)
	end
	def save_user(car)
		@already = User.find_by_email(params[:user][:email])
		@user =  User.new(new_params)
		@user.car_id = car.id
		@user.driver_id = current_user.id
		
		if @already.blank?
			if @user.save
				@user.add_role :driver
				is_save = true
			else
				is_save = false
				flash[:success] = 'User Already Exist'        
				render :new
			end
		else 
			is_save = false
			flash[:error] = "User Already Exist With this Email"
			render :new
		end
		return is_save
	end


	def get_car
		@car = Car.find_by_id(session[:car_id])
	end

	def check_user
		if  current_user and current_user.roles.first.try(:name) == "owner"
			
		elsif current_user and current_user.roles.first.try(:name) == "driver"
			redirect_to  dashboard_index_url
		else
			redirect_to root_url
		end
	end
end
