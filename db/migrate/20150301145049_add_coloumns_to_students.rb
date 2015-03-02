class AddColoumnsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :dob, :string
    add_column :students, :gender, :string
    add_column :students, :staus, :string
  end
end
