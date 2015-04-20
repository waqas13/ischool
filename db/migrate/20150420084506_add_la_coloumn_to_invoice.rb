class AddLaColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :la, :string
  end
end
