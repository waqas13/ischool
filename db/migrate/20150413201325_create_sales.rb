class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :bookNum
      t.string :customerName
      t.string :customerMobile
      t.float :paid
      t.string :status
      t.string :driver
      t.integer :customer_id
      t.string :vehicle

      t.timestamps
    end
  end
end
