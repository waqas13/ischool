class AddSaleColumnToLine < ActiveRecord::Migration
  def change
    add_column :lines, :sale_id, :integer
  end
end
