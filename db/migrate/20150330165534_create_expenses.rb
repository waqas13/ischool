class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :description
      t.integer :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
