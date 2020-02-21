# == Schema Information
#
# Table name: devices
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  mac_address      :string
#  name             :string
#  user_agent       :string
#  last_activity_at :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  track_time       :boolean          default(FALSE), not null
#

class Device < ApplicationRecord
  belongs_to :user

  has_many :presence_times, dependent: :delete_all

  scope :in_office, -> { where("devices.last_activity_at >= ?", 2.minutes.ago) }
  scope :running_tracker, -> { joins(:presence_times).where(presence_times: { end_at: nil }) }
  scope :tracking_time, -> { where(track_time: true) }

  validates :name, presence: true

  def in_office?
    last_activity_at && last_activity_at > 2.minutes.ago
  end

  def track_activity
    touch :last_activity_at
    start_time_tracking
  end

  def start_time_tracking
    return unless track_time? && presence_times.running.none?
    presence_times.create! start_at: DateTime.current
  end
end
