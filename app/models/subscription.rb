# == Schema Information
#
# Table name: subscriptions
#
#  id              :uuid             not null, primary key
#  product_id      :uuid             not null
#  team_id         :uuid             not null
#  canceled_at     :datetime
#  interval        :integer          default("monthly"), not null
#  next_renewal_at :datetime         not null
#  quantity        :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :team

  scope :active, -> { where(canceled_at: nil) }

  enum interval: { monthly: 0 }

  def active?
    canceled_at.nil?
  end

  def canceled?
    !active?
  end
end
