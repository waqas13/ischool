class AddVehicleFromInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :vehicle, :string
  end
end
