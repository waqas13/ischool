class AddDriverColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :driver, :string
    add_column :invoices, :vehicle, :integer
  end
end
