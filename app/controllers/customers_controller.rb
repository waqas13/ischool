class CustomersController < ApplicationController
  def new
  	@customer = Customer.new
  end

  def create
  	@customer = Customer.create(create_params)
  	@customer.total = 0
  	@customer.credit = 0
  	@customer.paid = 0
  	if @customer.save!
      redirect_to customers_path, :notice => 'Customer added successfully!'
    else
      redirect_to :back, :alert => "Sorry! Add the Customer again!"
    end
  end

  def index
  	@customers = Customer.all
  end

  private
    def create_params
      params.require(:customer).permit(:name, :contact)      
    end
end
