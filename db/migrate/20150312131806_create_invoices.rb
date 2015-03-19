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
    execute "SELECT setval('invoice_id_seq', 1000);"
  end
end
