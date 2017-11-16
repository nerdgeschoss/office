class CreatePresenceTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :presence_times, id: :uuid do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.uuid :device_id

      t.timestamps
    end
    add_index :presence_times, :end_at
    add_index :presence_times, :device_id
    add_foreign_key :presence_times, :devices
  end
end
