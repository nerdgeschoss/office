# == Schema Information
#
# Table name: presence_times
#
#  id         :uuid             not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime
#  device_id  :uuid
#  created_at :datetime         not nullPr
#  updated_at :datetime         not null
#

class PresenceTime < ApplicationRecord
  belongs_to :device

  scope :running, -> { where(end_at: nil) }
  scope :done, -> { where.not(end_at: nil) }
  scope :reverse_chronologic, -> { order(end_at: :desc) }
  scope :ready_for_close, -> { running.joins(:device).where("devices.last_activity_at < ?", 3.minutes.ago) }

  def duration
    (end_at || DateTime.current).to_i - start_at.to_i
  end

  def running?
    end_at.nil?
  end

  def close
    touch :end_at
  end
end
