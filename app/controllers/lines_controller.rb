class LinesController < ApplicationController
	def createBill
		puts'-'*80
		invoice = Sale.new
		if !Sale.exists?(params[:line][:sale_id])
			invoice = Sale.create
			puts'-'*80
		else
			invoice = Sale.find(params[:line][:sale_id])
		end
		bill = invoice.lines.create
		item = Item.find(params[:line][:item_id])

		bill.item_id = item.id
		bill.item_title = item.title
		bill.gross = params[:line][:gross]
		bill.tear = params[:line][:tear]
		bill.price = params[:line][:price]
		bill.save
  	respond_to do |format|
  		format.json {render json: 200}
  	end
  	# redirect_to invoices_new_path

	end

	def getbills
		total = Sale.last.lines.sum("price * (gross-tear)")
		b = Sale.last.lines
		respond_to do |format|
  		format.json {render json: [totalSum: total, b: b]}
  	end
	end

	def removebills
		bill = Line.find(params[:id])
		bill.destroy
		total = bill.sale.lines.sum("price * (gross-tear)")
		respond_to do |format|
  		format.json {render json: [id: params[:id], total: total ]}
  	end
	end

	def edit
		@invoice = Sale.find(params[:id])
		@bills = @invoice.lines.order(:id)
		@autogen = @invoice.id
	end

	def update
		bill = Line.find(params[:id])
		item = Item.find(bill.item_id)
		item.left = item.left + (bill.gross - bill.tear)
		item.left = item.left - (params[:line][:gross].to_i - params[:line][:tear].to_i)
		item.save
		inv = Sale.find(bill.sale_id)
		cust = Customer.find(inv.customer_id)
		cust.paid = cust.paid - (bill.price * (bill.gross-bill.tear))
		bill.price = params[:line][:price]
		bill.gross = params[:line][:gross]
		bill.tear = params[:line][:tear]
		bill.save
		cust.paid = cust.paid + (bill.price * (bill.gross-bill.tear))
		cust.save
		redirect_to edit_sale_path(bill.sale_id)
	end

	private
    def create_params
      params.require(:line).permit(:item_id, :invoice_id, :quantity, :price, :tear , :gross)      
    end
end
