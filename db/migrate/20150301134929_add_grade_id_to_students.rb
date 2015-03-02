class AddGradeIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :grade_id, :integer
  end
end
