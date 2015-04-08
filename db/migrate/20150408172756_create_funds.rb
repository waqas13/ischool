class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
