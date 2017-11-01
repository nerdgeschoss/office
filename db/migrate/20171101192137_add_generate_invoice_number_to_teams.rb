class AddGenerateInvoiceNumberToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :generate_invoice_number, :boolean, null: false, default: true
  end
end
