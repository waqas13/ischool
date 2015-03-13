class BillsController < ApplicationController
	def createBill
		puts'-'*80
		puts params
		puts '-'*80
		#@bill = params[:bill]
      	# respond_to do |format|
      	# 	format.json {render json: true}
      	# end
      	redirect_to invoices_new_path
	end
end
