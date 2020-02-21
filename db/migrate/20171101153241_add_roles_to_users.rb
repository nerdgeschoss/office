# frozen_string_literal: true

class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :roles, :string, array: true, default: "{}"
  end
end
