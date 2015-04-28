class AddDateColumnToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :date, :datetime
  end
end
