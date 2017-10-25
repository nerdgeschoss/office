# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  slug       :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  email      :string           not null
#  team_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    team
  end
end
