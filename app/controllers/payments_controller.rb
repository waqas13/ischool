class PaymentsController < ApplicationController
  def new
  	@payment = Payment.new
  end

  def create
  	# return render json: params
  	@payment = Payment.new(create_params)
  	customer = Customer.find(params[:payment][:customer_id])
  	customer.credit = customer.credit - @payment.total
  	customer.paid = customer.paid + @payment.total
  	customer.save  	
  	if @payment.save
  		redirect_to payments_path, :notice => 'Payment Paid Successfully...!!!'
  	end
  end

  def index
  	@payments = Payment.all
  end

    private
	    def create_params
	      params.require(:payment).permit(:customer_id, :total, :remarks)      
	    end
end
