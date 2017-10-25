# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  slug                   :string           not null
#  first_name             :string           not null
#  last_name              :string           not null
#  email                  :string           not null
#  team_id                :uuid             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team

  def name
    [first_name, last_name].join(" ")
  end
end
