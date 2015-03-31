class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :customer_id
      t.integer :advance
      t.integer :paid
      t.integer :total

      t.timestamps
    end
  end
end
