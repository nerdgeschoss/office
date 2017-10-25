class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices, id: :uuid do |t|
      t.uuid :team_id, null: false
      t.datetime :invoiced_at
      t.decimal :total, null: false
      t.decimal :vat, null: false
      t.decimal :total_brut, null: false

      t.timestamps
    end
    add_foreign_key :invoices, :teams
    add_index :invoices, :invoiced_at
  end
end
