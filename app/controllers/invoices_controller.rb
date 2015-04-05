class InvoicesController < ApplicationController
  def new
  	if current_user
	  	@invoice = Invoice.new
	  	@autogen = Invoice.last.id + 1
	  	@bill = @invoice.bills.new
	  	@bills = @invoice.bills
	else
		redirect_to authenticated_root_path(@autogen), :alert => 'Access Denied!'
	end
  end

  def updateInvoice
    puts 'as'*40
  	invoice = Invoice.find(params[:format])
    invoice.status = 'active'
    cust = Customer.find(params[:invoice][:customer_id])
    invoice.customerName = cust.name
    if invoice.update(update_params)
      cust.credit = cust.credit + invoice.bills.sum("(gross-tear) * price")
      cust.save
      redirect_to invoices_new_path, :notice => 'Invoice added successfully!'
    else
      redirect_to :back, :alert => 'Could not update information!'
    end
  end

  def index
    @invoices = Invoice.where.not(status: 'cancelled')
    # @total = Bill.where.not(invoice_id: nil).sum('quantity * pirice')
  end

  def credit
  	@invoice = Invoice.find(params[:id])
    @autogen = params[:id]
  	@bills = @invoice.bills
  	
  end

  def cancel
    invoice = Invoice.find(params[:id])
    invoice.status = 'cancelled'
    bills = invoice.bills
    bills.each do |bill|
      item = Item.find(bill.item_id)
      item.left = item.left + bill.quantity
      item.sold = item.sold - bill.quantity
      item.save!
    end
    invoice.save!
  end

  def customer
    # return render json: params
    @customer =  Customer.find(params[:id])
    @invoices = Invoice.where(customer_id: @customer.id)
  end

  def canceled
    @invoices = Invoice.where.not(bookNum: nil , status: nil)
  end

  private
    def update_params
      params.require(:invoice).permit(:id,:bookNum, :customerName,:customer_id, :customerMobile, :right, :left, :paid, :vehicle, :driver)      
    end
end
