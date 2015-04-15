class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.float :price
      t.string :code
      t.string :item_title
      t.integer :gross
      t.integer :tear

      t.timestamps
    end
  end
end
