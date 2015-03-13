class InvoicesController < ApplicationController
  def new
  	if current_user && current_user.user_type == 1
	  	@invoice = Invoice.create
	  	inv = Invoice.last
	  	if inv.blank?
	  		@autogen = 1
	  	else	
	  		@autogen = Invoice.last.id+1
	  	end
	  	@bill = @invoice.bills.new
	else
		redirect_to authenticated_root_path, :alert => 'Access Denied!'
	end
  end

  def index
  	@invoices = Invoice.all
  end
end
