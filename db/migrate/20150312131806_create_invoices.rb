class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :bookNum
      t.string :customerName
      t.string :customerMobile
      t.string :right
      t.string :left

      t.timestamps
    end
  end
end
