class UsersController < ApplicationController
	before_action :check_user , only:[:login , :new, :user_register, :user_login ,:register]
	def new
		@user = User.new
	end

	def login
		@user = User.new
	end

	def user_register
		@already = User.find_by_email(params[:user][:email])
		@user = User.new(new_params)
		if @already.blank?
			if @user.save
				@user.add_role :owner
				sign_in :user, @user
				redirect_to cars_url
			else
				flash[:success] = 'User Already Exist'        
				render :register
			end
		else
			flash[:success] = 'User Already Exist.'
			render :register
		end
	end


	def user_login
		@user  = User.find_by_email(params[:user][:email])
		if !@user.blank?
			if @user.valid_password?(params[:user][:password])
				if @user and @user.has_role? :owner
					sign_in :user, @user
					redirect_to cars_url
				elsif @user and @user.has_role? :driver
					sign_in :user, @user
					session[:car_id] = @user.car_id

					redirect_to  dashboard_index_url
				end
			else
				flash[:error] = 'Invalid Email.'
				render :login
			end
		else
			flash[:error] = 'Invalid Credentials.'
			render :login
		end
	end

	def register
		@user = User.new
	end

	def logout
		sign_out current_user  if current_user
		redirect_to root_url
	end 

	private

	def new_params
		params.require(:user).permit(:first_name, :last_name, :phone_number,:address, :email, :password)
	end

	def check_user
		if current_user
			if current_user.has_role? :owner
				redirect_to cars_url
			elsif current_user and current_user.has_role? :driver
				redirect_to  dashboard_index_url
			end
		else
			
		end 
	end
end
