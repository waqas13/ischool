class AddTitleColumnToBill < ActiveRecord::Migration
  def change
    add_column :bills, :item_title, :string
  end
end
