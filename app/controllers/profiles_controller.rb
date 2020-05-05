class ProfilesController < ApplicationController

	def onwer

	end

	
	def update 
		@user = current_user
		@already = User.find_by_email(params[:user][:email])
		if @already.blank? or params[:user][:email] == @user.email
			if @user.update(new_params)
				flash[:success] = 'Profile Successfully Update!' 
				sign_in(@user, :bypass=>true)
				if @user.roles.first.try(:name) == "owner"
					redirect_to cars_url 
				else
					redirect_to  dashboard_index_url
				end
			else
				flash[:error] = "Profile not Update Try Agian"
				render :onwer
			end
		else 
			flash[:error] = "Profile Already Exist With this Email"
			render :onwer
		end
	end 

	private

	def new_params
		params.require(:user).permit(:first_name, :last_name, :address, :phone_number, :email, :password)
	end

end
