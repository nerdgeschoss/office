# frozen_string_literal: true

class CreateInvoiceLines < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_lines, id: :uuid do |t|
      t.uuid :product_id, null: false
      t.decimal :price, null: false
      t.decimal :vat, null: false
      t.decimal :vat_rate, null: false
      t.uuid :ordered_by_id
      t.uuid :invoice_id, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
    add_foreign_key :invoice_lines, :products
    add_foreign_key :invoice_lines, :users, column: :ordered_by_id
    add_foreign_key :invoice_lines, :invoices
    add_index :invoice_lines, :invoice_id
  end
end
