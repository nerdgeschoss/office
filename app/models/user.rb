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
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  last_activity_at       :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  belongs_to :team
  has_many :devices, dependent: :destroy
  has_many :invoice_lines, dependent: :nullify, foreign_key: :ordered_by_id

  validates :first_name, :last_name, :email, :team_id, presence: true

  def name
    [first_name, last_name].join(" ")
  end

  def admin?
    roles.include? "admin"
  end

  def kiosk?
    roles.include? "kiosk"
  end

  def avatar_url(size = 80)
    hash = Digest::MD5.hexdigest(email.to_s.downcase)
    "https://www.gravatar.com/avatar/#{hash}?d=mm&s=#{size}"
  end

  def password_required?
    false
  end
end
