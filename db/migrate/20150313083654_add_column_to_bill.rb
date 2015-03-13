class AddColumnToBill < ActiveRecord::Migration
  def change
    add_column :bills, :code, :string
  end
end
