class Api::V1::AgreementsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		@car = Car.find_by_id(params[:car_id])
		@agreements = @car.agreements.paginate(page: params[:page])
	end 

	def create
		@agreement = Agreement.new(param_agreement)
		@agreement.car_id = params[:car_id]
		if @agreement.save
			
		else
			render :json=> {
				:success => "Agreement Not Create Try Agian"
			},:status => 200
		end 
	end
	def update
		@agreement = Agreement.find_by_id(params[:id])
		if @agreement.update(param_agreement)
			
		else
			render :json=> {
				:success => "Agreement Not Update Try Agian"
			},:status => 200
		end 
	end

	def destroy 
		@agreement = Agreement.find_by_id(params[:id])
		if @agreement.blank?
			render :json=> {
				:error => "Agreement did not find. Please try again later."
			},:status => 400
		else
			if @agreement.destroy
				render :json=> {
					:success => "Agreement Destroy."
				},:status => 200
			else
				render :json=> {
					:error => "Agreement did not Destroy. Please try again later."
				},:status => 400
			end
		end
	end 

	private 

	def param_agreement
		params.require(:agreement).permit(:first_name,:last_name,:start_date,:end_date,:car_id,:is_paid,:is_current,:phone_number,:price)
	end
	
end
