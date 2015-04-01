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
  	item = Item.find_by_code(params[:code])
  	if item.present?
  		redirect_to :back, :alert => 'Code already exist!'
  	elsif @item.save!
	  	redirect_to items_new_path, :notice => 'Item added successfully!'
  	end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    # return render json: params.inspect
    item = Item.find(params[:id])
    if item.update(create_params)
      redirect_to items_path(item.id), :notice => 'Information Updated successfully!'
    else
      redirect_to item_path(item.id), :alert => 'Could not update information!'
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path, :notice => 'Item Deleted!'
  end

  def validateItemCode

  	item = Item.find_by_code(params[:code])
    value = item.present?
    respond_to do |format|
      format.json {render json: value}
    end
  end

  def addStock
    @item = Item.new
  end

  def adding
    
    item = Item.find_by_code(params[:item][:code])
    item.left = item.left + params[:item][:left].to_i
    if item.save
      redirect_to addStock_items_path, :notice => 'Stock Added!'
    end
  end

  private
  	def create_params
      params.require(:item).permit(:code, :title, :detail, :sold, :left)     
    end
end
