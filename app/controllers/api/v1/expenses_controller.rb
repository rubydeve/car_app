class Api::V1::ExpensesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		@car = Car.find_by_id(params[:car_id])
		@expenses = @car.expenses.paginate(page: params[:page])
	end
	
	def create 
		@expense = Expense.new(param_expene)
		@expense.car_id = params[:car_id]
		if @expense.save
		else
			render :json=> {
				:success => "Expense Not Create Try Agian"
			},:status => 200
		end 
	end

	def update 
		@expense = Expense.find_by_id(params[:id])
		if @expense.update(param_expene)

		else
			render :json=> {
				:success => "Expense Not Update Try Agian"
			},:status => 200
		end 
	end 

	def destroy 
		@expense = Expense.find_by_id(params[:id])
		if @expense.blank?
			render :json=> {
				:error => "Expense did not find. Please try again later."
			},:status => 400
		else
			if @expense.destroy
				render :json=> {
					:success => "Expense Destroy."
				},:status => 200
			else
				render :json=> {
					:error => "Expense did not Destroy. Please try again later."
				},:status => 400
			end
		end
	end

	private 

	def param_expene
		params.require(:expense).permit(:name,:datetime,:car_id,:price)
	end
end
