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

  def validateItemCode

  	item = Item.find_by_code(params[:code])
    value = item.present?
    respond_to do |format|
      format.json {render json: value}
    end
  end

  private
  	def create_params
      params.require(:item).permit(:code, :title, :detail, :sold, :left)     
    end
end
