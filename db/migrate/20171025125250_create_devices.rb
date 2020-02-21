# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :mac_address
      t.string :name
      t.string :user_agent
      t.datetime :last_activity_at, null: false, default: "NOW()"

      t.timestamps
    end
    add_foreign_key :devices, :users
  end
end
