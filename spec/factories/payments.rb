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

FactoryBot.define do
  factory :payment do
    team
    amount "20"
  end
end
