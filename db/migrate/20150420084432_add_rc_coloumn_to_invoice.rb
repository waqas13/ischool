class AddRcColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :rc, :string
  end
end
