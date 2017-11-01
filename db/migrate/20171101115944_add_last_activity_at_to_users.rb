class AddLastActivityAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_activity_at, :datetime, null: false, default: -> { "NOW()" }
  end
end
