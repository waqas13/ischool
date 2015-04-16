class SalesController < ApplicationController
  def new
  	if current_user
      @credit = Customer.where.not(status: 'delete').order(:name).first.credit
	  	@invoice = Sale.new
      @autogen = Sale.last.id + 1
	  	@bill = @invoice.lines.new
	  	@bills = @invoice.lines
	else
		redirect_to authenticated_root_path(@autogen), :alert => 'Access Denied!'
	end
  end

  def updateInvoice
    puts 'as'*40
  	invoice = Sale.find(params[:format])
    invoice.status = 'active'
    cust = Customer.find(params[:sale][:customer_id])
    invoice.customerName = cust.name
    if invoice.update(update_params)
      cust.paid = cust.paid + invoice.lines.sum("(gross-tear) * price")
      cust.credit = cust.credit - invoice.lines.sum("(gross-tear) * price")
      cust.save
      invoice.lines.each do |bill|
        item = Item.find(bill.item_id)
        item.left = item.left - (bill.gross - bill.tear)
        item.save
      end
      redirect_to sales_path, :notice => 'Invoice added successfully!'
    else
      redirect_to :back, :alert => 'Could not update information!'
    end
  end

  def index
    @invoices = Sale.where(status: 'active')
    # @total = Bill.where.not(invoice_id: nil).sum('quantity * pirice')
  end

  def credit
  	@invoice = Sale.find(params[:id])
    @autogen = params[:id]
  	@bills = @invoice.lines
  	
  end

  def cancel
    invoice = Sale.find(params[:id])
    invoice.status = 'cancelled'
    bills = invoice.lines
    bills.each do |bill|
      item = Item.find(bill.item_id)
      item.left = item.left + bill.quantity
      item.sold = item.sold - bill.quantity
      item.save!
    end
    invoice.save!
  end

  def destroy
    invoice = Sale.find(params[:id])
    cust = Customer.find(invoice.customer_id)
    cust.credit = cust.credit + invoice.lines.sum('price * (gross-tear)')
    cust.paid = cust.paid - invoice.lines.sum('price * (gross-tear)')
    cust.save
    invoice.lines.each do |bill|
      item = Item.find(bill.item_id)
      item.left = item.left + (bill.gross - bill.tear)
      item.save
    end
    invoice.lines.destroy_all
    invoice.destroy
    Sale.create
    redirect_to sales_path, :alert => 'Invoice Deleted successfully'
  end

  def customer
    # return render json: params
    @customer =  Customer.find(params[:id])
    @invoices = Sale.where(customer_id: @customer.id)
  end

  def canceled
    @invoices = Sale.where.not(bookNum: nil , status: nil)
  end

  private
    def update_params
      params.require(:sale).permit(:id,:bookNum, :customerName,:customer_id, :customerMobile, :right, :left, :paid, :vehicle, :driver)      
    end
end
