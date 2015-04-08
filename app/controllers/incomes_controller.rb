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

  private
	def create_params
    params.require(:income).permit(:amount, :ramark, :user_id)     
  end
end
