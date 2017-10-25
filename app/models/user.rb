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

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :team

  def name
    [first_name, last_name].join(" ")
  end
end
