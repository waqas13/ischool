class AddRsColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :rs, :string
  end
end
