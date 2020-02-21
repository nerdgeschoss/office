# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.uuid :product_id, null: false
      t.uuid :team_id, null: false
      t.datetime :canceled_at
      t.integer :interval, null: false, default: 0
      t.datetime :next_renewal_at, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
    add_foreign_key :subscriptions, :products
    add_foreign_key :subscriptions, :teams
    add_index :subscriptions, :canceled_at
    add_index :subscriptions, :next_renewal_at
  end
end
