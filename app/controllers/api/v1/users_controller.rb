class Api::V1::UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def user_register
		@already = User.find_by_email(params[:user][:email])
		@user = User.new(new_params)
		if @already.blank?
			if @user.save
				@user.add_role :owner
				sign_in :user, @user
				
			else
				render :json=> {
					:error => "Account did not created. Please try again later."
				},:status => 400
			end
		else
			render :json=> {
				:error => "Email already exists. Please choose a different Email."
			},:status => 400
		end
	end


	def user_login
		@user = User.find_by_email(params[:user][:email])
		if !@user.blank?
			if @user.valid_password?(params[:user][:password])
				sign_in :user, @user
			else
				render :json=> {
					:error => "Invalid Password."
				},:status => 400
			end
		else
			render :json=> {
				:error => "User did not exist with this Email."
			},:status => 400
		end
	end

	def logout
		@user = User.find_by_id(params[:id])
		sign_out @user  if @user
		# redirect_to root_url
	end 

	private

	def new_params
		params.require(:user).permit(:first_name, :last_name, :phone_number,:address, :email, :password)
	end
	
end
