# frozen_string_literal: true

class AddTrackTimeToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :track_time, :boolean, null: false, default: false
    add_index :devices, :track_time
  end
end
