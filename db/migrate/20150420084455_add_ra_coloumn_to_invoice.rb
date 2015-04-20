class AddRaColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :ra, :string
  end
end
