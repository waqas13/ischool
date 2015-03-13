class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :title
      t.string :detail
      t.integer :sold
      t.integer :left

      t.timestamps
    end
  end
end
