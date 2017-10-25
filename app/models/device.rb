# == Schema Information
#
# Table name: devices
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  mac_address      :string
#  name             :string
#  user_agent       :string
#  last_activity_at :datetime         default(Wed, 25 Oct 2017 12:54:46 UTC +00:00), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Device < ApplicationRecord
  belongs_to :user
end
