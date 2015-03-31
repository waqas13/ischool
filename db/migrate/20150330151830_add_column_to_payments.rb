class AddColumnToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :remarks, :string
  end
end
