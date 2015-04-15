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
      invoice.bills.each do |bill|
        item = Item.find(bill.item_id)
        item.left = item.left + (bill.gross - bill.tear)
        item.save
      end
      redirect_to invoices_path, :notice => 'Invoice added successfully!'
    else
      redirect_to :back, :alert => 'Could not update information!'
    end
  end

  def index
    @invoices = Invoice.where(status: 'active')
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

  def destroy
    invoice = Invoice.find(params[:id])
    cust = Customer.find(invoice.customer_id)
    cust.credit = cust.credit - invoice.bills.sum('price * (gross-tear)')
    cust.save
    invoice.bills.each do |bill|
      item = Item.find(bill.item_id)
      item.left = item.left - (bill.gross - bill.tear)
      item.save
    end
    invoice.bills.destroy_all
    invoice.destroy
    Invoice.create
    redirect_to invoices_path, :alert => 'Invoice Deleted successfully'
  end

  def customer
    # return render json: params
    customer =  Customer.find(params[:id])
    @name = customer.name
    invoices = Invoice.where(customer_id: customer.id)
    @customer = []
    invoices.each do |inv|
      @customer.push(inv)
    end
    payments = Payment.where(customer_id: customer.id)
    payments.each do |pay|
      @customer.push(pay)
    end
    sales = Sale.where(customer_id: customer.id)
    sales.each do |sale|
      @customer.push(sale)
    end    
    @customer = @customer.sort_by &:created_at
    total = 0
    @customer.each do |cust|
      if cust.instance_of? Invoice
        total = total + cust.bills.sum("(gross-tear) * price")
      elsif cust.instance_of? Payment
        total = total - cust.total
      elsif cust.instance_of? Sale
        total = total - cust.lines.sum("(gross-tear) * price")
      end
    end
    @total = 0
  end

  def canceled
    @invoices = Invoice.where.not(bookNum: nil , status: nil)
  end

  private
    def update_params
      params.require(:invoice).permit(:id,:bookNum, :customerName,:customer_id, :customerMobile, :right, :left, :paid, :vehicle, :driver)      
    end
end
