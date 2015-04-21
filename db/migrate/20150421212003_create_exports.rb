class CreateExports < ActiveRecord::Migration
  def change
    create_table :exports do |t|
      t.integer :item_id
      t.string :container
      t.string :booking
      t.string :loading
      t.string :port
      t.string :party
      t.string :agent
      t.string :remarks
      t.string :weight

      t.timestamps
    end
  end
end
