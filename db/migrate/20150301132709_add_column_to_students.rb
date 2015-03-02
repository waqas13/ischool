class AddColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :email, :string
    add_column :students, :contact, :string
    add_column :students, :rollnum, :string
    add_column :students, :sirname, :string
    add_column :students, :address, :string
  end
end
