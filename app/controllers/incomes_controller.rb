class IncomesController < ApplicationController
  def index
  	@incomes = Income.all
  	@total = Fund.first.amount
  end

  def new
  	@income = Income.new
  end

  def create
  	income = Income.create(create_params)
  	income.user_id = current_user.id
  	income.save
  	fund = Fund.first
  	fund.amount = fund.amount + income.amount
  	fund.save
  	redirect_to incomes_path, :notice => 'Funds added successfully'
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    income = Income.find(params[:id])
    f = Fund.first
    f.amount = f.amount - income.amount
    if income.update(create_params)
      f.amount = f.amount + income.amount
      f.save
      redirect_to incomes_path, notice: "Income updated successfully"
    end
  end

  def destroy
    income = Income.find(params[:id])
    f = Fund.first
    f.amount = f.amount - income.amount
    f.save
    if income.destroy
      redirect_to incomes_path, alert: 'Income Deleted successfully'
    end
  end

  private
	def create_params
    params.require(:income).permit(:amount, :ramark, :user_id)     
  end
end
