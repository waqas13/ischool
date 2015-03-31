class ExpensesController < ApplicationController
	def index
	  	@expenses = Expense.all
	end

	def new
	  	@expense = Expense.new
	end

	def create
	  	exp = Expense.new(create_params)
	  	exp.user_id = current_user.id
	  	
	  	if exp.save
	  		redirect_to expenses_path, :notice => "Expense Submitted Successfully...!!!"
	  	end
	end

    private
	    def create_params
	      params.require(:expense).permit(:user_id, :amount, :description)      
	    end
end
