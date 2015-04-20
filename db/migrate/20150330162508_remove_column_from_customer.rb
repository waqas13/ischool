class RemoveColumnFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :paid, :string
  end
end
