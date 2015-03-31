class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :salary_type
      t.integer :loan
      t.integer :salary
      t.string :contact
      t.string :iqama
      t.string :expire_iqama
      t.string :address_home

      t.timestamps
    end
  end
end
