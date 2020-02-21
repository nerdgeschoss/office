# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :billing_address
      t.string :slug, null: false

      t.timestamps
    end
    add_index :teams, :slug, unique: true
  end
end
