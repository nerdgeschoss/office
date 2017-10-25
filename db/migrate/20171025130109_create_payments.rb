class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.uuid :team_id, null: false
      t.decimal :amount, null: false
      t.string :subject

      t.timestamps
    end
    add_foreign_key :payments, :teams
  end
end
