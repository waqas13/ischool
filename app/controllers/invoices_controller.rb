class InvoicesController < ApplicationController
  def new
    if current_user
      @invoice = Invoice.create
      @autogen = Invoice.last.id
      @bill = @invoice.bills.new
      @bills = @invoice.bills
  else
    redirect_to authenticated_root_path, :alert => 'Access Denied!'
  end
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.status = 'active'
    if invoice.update(update_params)
      redirect_to invoices_path, :notice => 'Invoice added successfully!'
    else
      redirect_to :back, :alert => 'Could not update information!'
    end
  end

  def index
    @invoices = Invoice.where.not(bookNum: nil)
    @invoices = @invoices.where.not(status: 'cancelled')
    # @total = Bill.where.not(invoice_id: nil).sum('quantity * pirice')
  end

  def credit
    @invoice = Invoice.find(params[:id])
    @autogen = @invoice.id
    @bills = @invoice.bills
    
  end

  def cancel
    invoice = Invoice.find(params[:id])
    invoice.status = 'cancelled'
    invoice.save!
    bills = invoice.bills
    bills.each do |bill|
      item = Item.find(bill.item_id)
      item.left = item.left + bill.quantity
      item.sold = item.sold - bill.quantity
      item.save!
    end
    redirect_to invoices_path
  end

  def canceled
    @invoices = Invoice.where.not(bookNum: nil , status: nil)
  end

  def destroy
    inv = Invoice.find(params[:id])
    inv.destroy
    redirect_to canceled_invoices_path, :notice => 'Invoice Deleted!'
  end

  private
    def update_params
      params.require(:invoice).permit(:bookNum, :customerName, :customerMobile, :right, :left, :paid)      
    end
end
