class ExportsController < ApplicationController
  before_action :set_export, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @exports = Export.all
    respond_with(@exports)
  end

  def show
    respond_with(@export)
  end

  def new
    @export = Export.new
    respond_with(@export)
  end

  def edit
  end

  def create
    @export = Export.new(export_params)
    @export.save
    item = Item.find(@export.item_id)
    item.left = item.left - @export.weight.to_i
    item.save
    respond_with(@export)
  end

  def update
    item = Item.find(@export.item_id)
    item.left = item.left + @export.weight.to_i
    @export.update(export_params)
    item.left = item.left - @export.weight.to_i
    item.save
    respond_with(@export)
  end

  def destroy
    item = Item.find(@export.item_id)
    item.left = item.left + @export.weight.to_i
    item.save
    @export.destroy
    respond_with(@export)
  end

  private
    def set_export
      @export = Export.find(params[:id])
    end

    def export_params
      params.require(:export).permit(:item_id, :container, :booking, :loading, :port, :party, :agent, :remarks, :weight)
    end
end
