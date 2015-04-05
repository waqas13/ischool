class BillsController < ApplicationController
	def createBill
		puts'-'*80
		invoice = Invoice.last
		if !Invoice.exists?(params[:bill][:invoice_id])
			invoice = Invoice.create
			puts'-'*80
		end
		bill = invoice.bills.create
		item = Item.find(params[:bill][:item_id])

		bill.item_id = item.id
		bill.item_title = item.title
		bill.gross = params[:bill][:gross]
		bill.tear = params[:bill][:tear]
		bill.price = params[:bill][:price]
		bill.save
		item.left = item.left + bill.gross - bill.tear
		item.save
      	respond_to do |format|
      		format.json {render json: 200}
      	end
      	# redirect_to invoices_new_path

	end

	def getbills
		total = Invoice.last.bills.sum("price * (gross-tear)")
		b = Invoice.last.bills
		respond_to do |format|
      		format.json {render json: [totalSum: total, b: b]}
      	end
	end

	def removebills
		bill = Bill.find(params[:id])
		item = Item.find(bill.item_id)
		item.left = item.left - (bill.gross - bill.tear)
		item.save!
		bill.destroy
		total = Invoice.last.bills.sum("price * (gross-tear)")
		respond_to do |format|
      		format.json {render json: [id: params[:id], total: total ]}
      	end
	end

	private
	    def create_params
	      params.require(:bill).permit(:item_id, :invoice_id, :quantity, :price, :tear , :gross)      
	    end
end
