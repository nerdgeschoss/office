# == Schema Information
#
# Table name: invoices
#
#  id             :uuid             not null, primary key
#  team_id        :uuid             not null
#  invoiced_at    :datetime
#  total          :decimal(, )      not null
#  vat            :decimal(, )      not null
#  total_brut     :decimal(, )      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invoice_number :integer
#

FactoryBot.define do
  factory :invoice do
    team
    invoiced_at { DateTime.current }
  end
end
