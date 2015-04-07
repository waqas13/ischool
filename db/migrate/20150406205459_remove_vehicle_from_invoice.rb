class RemoveVehicleFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :vehicle, :string
  end
end
