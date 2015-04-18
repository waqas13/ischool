class ItemsController < ApplicationController
  def index
  	if current_user && current_user.user_type == 0
  		@items = Item.where.not(status: 'delete')
  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.new(create_params)
    @item.left = 0
    @item.status = 'active'
    if @item.save
      redirect_to items_path :notice => "Item Added Successfully!!"
    else
      redirect_to :back, alert: 'Item with this name Already Exist'
    end 	
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.title = params[:item][:title]
    @item.save
    redirect_to items_path, :alert => 'Item Updated'
  end

  def show
    @item = Item.find(params[:id])
    @bills = @item.bills
  end

  def addStock
    @item = Item.new
    @items = Item.all
  end

  def adding
    item = Item.find(params[:item][:id])
    item.left = item.left.to_i - params[:item][:left].to_i
    item.save
    b = Bill.new
    b.gross = params[:item][:left].to_i
    b.item_id = item.id
    b.item_title = item.title
    b.code = 'export'
    b.save
    redirect_to export_items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.status = 'delete'
    item.save
    redirect_to items_path, :notice => 'Item Deleted!'
  end

  def export
    @bills = Bill.where(code: 'export')
  end

  private
  	def create_params
      params.require(:item).permit(:title, :status, :left)     
    end
end
