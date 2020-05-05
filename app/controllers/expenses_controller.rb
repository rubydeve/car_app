class ExpensesController < ApplicationController
	
	before_action :check_user 

	def index
		@car = Car.find_by_id(session[:car_id])
		@expenses = @car.expenses.paginate(page: params[:page])
	end

	def new
		@expense = Expense.new
	end
	
	def show
		@expense = Expense.find_by_id(params[:id])
	end

	def create 
		@expense = Expense.new(param_expene)
		@expense.car_id = session[:car_id]
		if @expense.save
			flash[:success] = 'Expense Successfully Created!' 
			redirect_to expenses_url
		else
			puts"asdasdlaksdj",@agreement.errors.messages.inspect
			flash[:error] = 'Expense Not Create Try Agian'  
			render :new
		end 
	end 
	def edit 
		@expense = Expense.find_by_id(params[:id])
	end

	def update
		@expense = Expense.find_by_id(params[:id])
		if @expense.update(param_expene)
			flash[:success] = 'Expense Successfully Updated!' 
			redirect_to expenses_url
		else
			flash[:error] = 'Expense Not Update Try Agian'  
			render :edit
		end 
	end 

	def destroy
		@expense = Expense.find_by_id(params[:id])
		if @expense.destroy
			flash[:success] = 'Expense Successfully Destroy!' 
			redirect_to expenses_url
		else
			flash[:error] = 'Expense Not Destroy Try Agian'  
			redirect_to expenses_url
		end 
	end

	private 

	def param_expene
		params.require(:expense).permit(:name,:datetime,:car_id,:price)
	end
	def check_user
		if current_user
		else
			redirect_to root_url
		end
	end
end
