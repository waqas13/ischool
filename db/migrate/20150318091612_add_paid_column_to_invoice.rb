class AddPaidColumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :paid, :float
  end
end
