# == Schema Information
#
# Table name: devices
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  mac_address      :string
#  name             :string
#  user_agent       :string
#  last_activity_at :datetime         default(Wed, 25 Oct 2017 13:10:45 UTC +00:00), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :device do
    user
    mac_address { Faker::Internet.mac_address }
    user_agent { Faker::Internet.user_agent }
  end
end
