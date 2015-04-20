class AddTotalColumnFromCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :total, :integer
  end
end
