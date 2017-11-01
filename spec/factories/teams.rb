# == Schema Information
#
# Table name: teams
#
#  id                      :uuid             not null, primary key
#  name                    :string           not null
#  billing_address         :jsonb
#  slug                    :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  website                 :string
#  generate_invoice_number :boolean          default(TRUE), not null
#

FactoryBot.define do
  factory :team do
    name { [Faker::Company.name, Faker::Company.suffix].join(" ") }
  end
end
