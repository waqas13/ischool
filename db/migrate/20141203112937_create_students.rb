class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :branch
      t.string :grade
      t.integer :amount
      t.integer :paid, :default => 0
      t.datetime :date 

      t.timestamps
    end
  end
end
