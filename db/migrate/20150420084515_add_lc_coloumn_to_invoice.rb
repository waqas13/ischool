class AddLcColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :lc, :string
  end
end
