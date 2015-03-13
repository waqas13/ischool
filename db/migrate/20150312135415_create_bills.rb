class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
