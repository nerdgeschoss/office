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

require "rails_helper"

RSpec.describe PresenceTime, type: :model do
end
