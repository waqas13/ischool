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
    fund = Fund.first
    fund.amount = fund.amount - @payment.total
    fund.save	
  	if @payment.save
  		redirect_to payments_path, :notice => 'Payment Paid Successfully...!!!'
  	end
  end

  def index
  	@payments = Payment.all
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    pay = Payment.find(params[:id])
    cust = Customer.find(pay.customer_id)
    cust.paid = cust.paid - pay.total
    cust.credit = cust.credit + pay.total
    f = Fund.first
    f.amount = f.amount + pay.total
    pay.total = params[:payment][:total]
    pay.save
    f.amount = f.amount - pay.total
    f.save
    cust.paid = cust.paid + pay.total
    cust.credit = cust.credit - pay.total
    cust.save
    redirect_to payments_path
  end

  def destroy
    pay = Payment.find(params[:id])
    cust = Customer.find(pay.customer_id)
    cust.paid = cust.paid - pay.total
    cust.credit = cust.credit + pay.total
    cust.save
    pay.destroy
    redirect_to payments_path
  end

    private
	    def create_params
	      params.require(:payment).permit(:customer_id, :total, :remarks)      
	    end
end
