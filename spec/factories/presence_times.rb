# == Schema Information
#
# Table name: presence_times
#
#  id         :uuid             not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime
#  device_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :presence_time do
    start_at "2017-11-16 18:19:24"
    end_at "2017-11-16 18:19:24"
    device_id ""
  end
end
