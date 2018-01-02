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
  scope :due, -> { active.where("subscriptions.next_renewal_at < NOW() AND subscriptions.canceled_at IS NULL") }

  enum interval: { monthly: 0 }

  validates :product, :team, :interval, :next_renewal_at, :quantity, presence: true

  def active?
    canceled_at.nil?
  end

  def canceled?
    !active?
  end

  def due?
    !canceled? && next_renewal_at < DateTime.current
  end

  def perform!
    return unless due?
    transaction do
      team.open_invoice.lines.create! product_id: product_id, quantity: quantity, created_at: next_renewal_at
      update! next_renewal_at: next_renewal_at + 1.month
    end
  end
end
