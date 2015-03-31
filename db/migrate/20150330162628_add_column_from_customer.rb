class AddColumnFromCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :paid, :integer
  end
end
