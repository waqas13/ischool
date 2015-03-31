class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :employee_id
      t.integer :loan_amount

      t.timestamps
    end
  end
end
