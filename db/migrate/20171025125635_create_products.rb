class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :available_in_kiosk, null: false, default: false
      t.decimal :price, null: false
      t.decimal :vat, null: false
      t.decimal :vat_rate, null: false
      t.boolean :deprecated, null: false, default: false

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :available_in_kiosk
    add_index :products, :deprecated
  end
end
