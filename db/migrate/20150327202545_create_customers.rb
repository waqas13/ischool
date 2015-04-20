class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact
      t.integer :credit
      t.string :paid
      t.string :total

      t.timestamps
    end
  end
end
