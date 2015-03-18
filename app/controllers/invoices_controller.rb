class InvoicesController < ApplicationController
  def new
  	if current_user && current_user.user_type == 1
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
    if invoice.update(update_params)
      redirect_to invoices_new_path, :notice => 'Invoice added successfully!'
    else
      redirect_to :back, :alert => 'Could not update information!'
    end
  end

  def index
  	@invoices = Invoice.where.not(bookNum: nil)
  end

  private
    def update_params
      params.require(:invoice).permit(:bookNum, :customerName, :customerMobile, :right, :left)      
    end
end
