# == Schema Information
#
# Table name: teams
#
#  id              :uuid             not null, primary key
#  name            :string           not null
#  billing_address :jsonb
#  slug            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  website         :string
#

FactoryBot.define do
  factory :team do
    name { [Faker::Company.name, Faker::Company.suffix].join(" ") }
  end
end
