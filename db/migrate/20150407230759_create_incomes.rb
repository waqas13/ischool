class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :amount
      t.integer :user_id
      t.string :ramark

      t.timestamps
    end
  end
end