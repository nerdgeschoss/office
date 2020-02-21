# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :uuid             not null, primary key
#  team_id    :uuid             not null
#  amount     :decimal(, )      not null
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ApplicationRecord
  belongs_to :team

  validates :amount, presence: true

  def accounting_amount
    amount
  end
end
