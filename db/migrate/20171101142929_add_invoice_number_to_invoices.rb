class AddInvoiceNumberToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :invoice_number, :integer
    add_index :invoices, :invoice_number, unique: true
  end
end
