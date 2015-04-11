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
  	fund = Fund.first
  	fund.amount = fund.amount - exp.amount
  	fund.save
  	
  	if exp.save
  		redirect_to expenses_path, :notice => "Expense Submitted Successfully...!!!"
  	end
	end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    exp = Expense.find(params[:id])
    f = Fund.first
    f.amount = f.amount + exp.amount
    if exp.update(create_params)
      f.amount = f.amount - exp.amount
      f.save
      redirect_to expenses_path, notice: 'Expense updateed Successfully'
    end
  end

  def destroy
    exp = Expense.find(params[:id])
    f = Fund.first
    f.amount = f.amount + exp.amount
    f.save
    exp.destroy
    redirect_to expenses_path, alert: 'Expense deleted'
  end

  private
    def create_params
      params.require(:expense).permit(:user_id, :amount, :description)      
    end
end
