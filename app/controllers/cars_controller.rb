class CarsController < ApplicationController
	before_action :check_user 

	def index
		@cars = current_user.cars
	end 

	def new
		@car = Car.new
	end 

	def show
		session[:car_id] = params[:id]
		redirect_to dashboard_index_url 
	end

	def create 
		
		if !params[:car][:avatar].blank?
			uploaded_io = params[:car][:avatar]
			@file_path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
			if File.exist?(@file_path)
				generate_token()
			else

			end
			File.open(@file_path, 'wb') do |file|
				f = file.write(uploaded_io.read)
			end

			session[:car] = params[:car]
			session[:car]["avatar"] = @file_path

			if session[:car]
				redirect_to new_driver_url
			else 
				@car = Car.new
				render :new
			end 
		else
		    @car = Car.new
			render :new
		end
	end 

	def edit 
		@car = Car.find_by_id(params[:id])
	end 

	def update
		@car = Car.find_by_id(params[:id])
		if @car.update(param_car) 
			flash[:success] = 'Car Successfully Update!' 
			redirect_to cars_url
		else
			flash[:error] = 'Car Not Update Try Agian'  
			render :edit
		end 
	end

	def destroy 
		@car = Car.find_by_id(params[:id])
		if @car.destroy
			flash[:success] = 'Car Successfully Destroy!' 
			redirect_to cars_url
		else
			flash[:error] = 'Car Not Destroy Try Agian'  
			redirect_to cars_url
		end 
	end

	private

	def param_car
		params.require(:car).permit(:model,:color,:transmission,:fuel_type,:name,:user_id,:avatar)
	end

	def check_user
		if  current_user and current_user.has_role? :owner
			
		elsif current_user and current_user.has_role? :driver
			redirect_to  dashboard_index_url
		else
			redirect_to root_url
		end
	end

	
	def generate_token
		loop do
			@file_path = SecureRandom.base64(15).tr('+/=', '0aZ').strip.delete("\n")
			@file_path = Rails.root.join('public', 'uploads', @file_path)
			break @file_path unless File.exist?(@file_path)
		end
	end



end
