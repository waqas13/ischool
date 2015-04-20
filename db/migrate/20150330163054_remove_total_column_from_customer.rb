class RemoveTotalColumnFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :total, :string
  end
end
