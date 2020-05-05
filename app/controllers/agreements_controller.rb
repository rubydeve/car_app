class AgreementsController < ApplicationController
	before_action :check_user 

	def index
		@car = Car.find_by_id(session[:car_id])
		@agreements = @car.agreements.paginate(page: params[:page])
	end 

	def show
		@agreement = Agreement.find_by_id(params[:id])	
	end

	def new
		@agreement = Agreement.new
	end 

	def create
		@agreement = Agreement.new(param_agreement)
		@agreement.car_id = session[:car_id]
		if @agreement.save
			flash[:success] = 'Agreement Successfully Created!' 
			redirect_to agreements_url
		else
			flash[:error] = 'Agreement Not Create Try Agian'  
			render :new
		end 
	end

	def edit
		@agreement = Agreement.find_by_id(params[:id])
	end

	def update
		@agreement = Agreement.find_by_id(params[:id])
		if @agreement.update(param_agreement)
			flash[:success] = 'Agreement Successfully Updated!' 
			redirect_to agreements_url
		else
			flash[:error] = 'Agreement Not Update Try Agian'  
			render :edit
		end 
	end

	def destroy 
		@agreement = Agreement.find_by_id(params[:id])
		if @agreement.destroy
			flash[:success] = 'Agreement Successfully Destroy!' 
			redirect_to agreements_url
		else
			flash[:error] = 'Agreement Not Destroy Try Agian'  
			redirect_to agreements_url
		end 
	end 

	private 

	def param_agreement
		params.require(:agreement).permit(:first_name,:last_name,:start_date,:end_date,:car_id,:is_paid,:is_current,:phone_number,:price)
	end
	
	
	def check_user
		if current_user
			
		else
			redirect_to root_url
		end
	end
end
