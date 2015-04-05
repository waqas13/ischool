class ItemsController < ApplicationController
  def index
  	if current_user && current_user.user_type == 0
  		@items = Item.all
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
    if @item.save
      redirect_to new_item_path :notice => "Item Added Successfully!!"
    end 	
  end

  def addStock
    @item = Item.new
    @items = Item.all
  end

  def adding
    item = Item.find(params[:item][:id])
    item.left = item.left.to_i - params[:item][:left].to_i
    item.save
    redirect_to items_path
  end

  private
  	def create_params
      params.require(:item).permit(:title)     
    end
end
