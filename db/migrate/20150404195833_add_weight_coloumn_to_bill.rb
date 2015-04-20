class AddWeightColoumnToBill < ActiveRecord::Migration
  def change
    add_column :bills, :gross, :integer
    add_column :bills, :tear, :integer
  end
end
