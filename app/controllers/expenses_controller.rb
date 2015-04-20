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

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    exp = Expense.find(params[:id])
    if exp.update(create_params)
      redirect_to expenses_path, notice: 'Expense updateed Successfully'
    end
  end

  def destroy
    exp = Expense.find(params[:id])
    exp.destroy
    redirect_to expenses_path, alert: 'Expense deleted'
  end

  private
    def create_params
      params.require(:expense).permit(:user_id, :amount, :description)      
    end
end
