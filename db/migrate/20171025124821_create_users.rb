# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :slug, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.uuid :team_id, null: false

      t.timestamps
    end
    add_foreign_key :users, :teams
    add_index :users, :slug, unique: true
  end
end
