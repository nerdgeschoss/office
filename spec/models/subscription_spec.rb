# == Schema Information
#
# Table name: subscriptions
#
#  id              :uuid             not null, primary key
#  product_id      :uuid             not null
#  team_id         :uuid             not null
#  canceled_at     :datetime
#  interval        :integer          default(0), not null
#  next_renewal_at :datetime         not null
#  quantity        :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "rails_helper"

RSpec.describe Subscription, type: :model do
end
