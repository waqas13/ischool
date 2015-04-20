class AddLsColoumnToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :ls, :string
  end
end
