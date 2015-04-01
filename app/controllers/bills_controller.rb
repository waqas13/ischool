class BillsController < ApplicationController
	def createBill
		if Invoice.last.id.to_s != params[:bill][:invoice_id].to_s
			puts'-'*80
			puts params
			puts '-'*80
			Invoice.create
		end
		@bill = Invoice.last.bills.create(create_params)
		item = Item.find_by_code(params[:bill][:code])
		if item.sold.to_i > 0
			item.sold = item.sold + params[:bill][:quantity].to_i
		else
			item.sold = params[:bill][:quantity].to_i
		end
		if item.left.to_i > 0
			item.left = item.left - params[:bill][:quantity].to_i
		else
			item.left = 0
		end
		item.save!
 		@bill.item_id = item.id
		@bill.item_title = item.title
		@bill.save!
      	respond_to do |format|
      		format.json {render json: 200}
      	end
      	# redirect_to invoices_new_path

	end

	def getbills
		puts '='*80
		puts params
		puts '+'*80
		bill = Invoice.last.bills.last
		total = Invoice.last.bills.sum("price * quantity")
		tit = Item.find(bill.item_id).title
		b = Invoice.last.bills
		respond_to do |format|
      		format.json {render json: [totalSum: total, b: b,titl: tit,quantity: bill.quantity,price: bill.price,total: bill.quantity*bill.price]}
      	end
	end

	def removebills
		bill = Bill.find(params[:id])
		item = Item.find(bill.item_id)
		item.sold = item.sold - bill.quantity
		item.left = item.left + bill.quantity
		item.save!
		bill.destroy
		respond_to do |format|
      		format.json {render json: [id: params[:id]]}
      	end
	end

	def validateCode
		bill = Item.find_by_code(params[:code])
		value = bill.present?
	    respond_to do |format|
	      format.json {render json: value}
	    end
	end

	private
	    def create_params
	      params.require(:bill).permit(:item_id, :invoice_id, :quantity, :price, :code)      
	    end
end
