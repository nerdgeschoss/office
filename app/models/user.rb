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
#  roles                  :string           default([]), is an Array
#  archived_at            :datetime
#  oauth_token            :string
#

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  time_for_a_boolean :archived

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  belongs_to :team
  has_many :devices, dependent: :destroy
  has_many :presence_times, through: :devices, dependent: false
  has_many :invoice_lines, dependent: :nullify, foreign_key: :ordered_by_id

  validates :first_name, :last_name, :email, :team_id, presence: true

  scope :with_role, ->(role) { where "? = ANY(users.roles)", role.to_s }
  scope :without_role, ->(role) { where "users.roles = '{}' OR ? != ANY(users.roles)", role.to_s }
  scope :visible_in_kiosk, -> { without_role(:kiosk).where(archived_at: nil) }
  scope :alphabetical, -> { order(first_name: :asc, last_name: :asc) }
  scope :in_office, -> { where id: Device.in_office.select(:user_id) }

  class << self
    def authenticate_with_token(token)
      user = User.find_by(oauth_token: token)
      user&.update! oauth_token: nil
      user
    end
  end

  def create_oauth_token
    self.oauth_token = SecureRandom.hex
    save!
    oauth_token
  end

  def name
    [first_name, last_name].join(" ")
  end

  def admin?
    roles.include? "admin"
  end

  def kiosk?
    roles.include? "kiosk"
  end

  def invite_pending?
    encrypted_password.blank?
  end

  def in_office?
    devices.any?(&:in_office?)
  end

  def last_time_in_office
    devices.map(&:last_activity_at).min
  end

  def avatar_url(size = 80)
    hash = Digest::MD5.hexdigest(email.to_s.downcase)
    "https://www.gravatar.com/avatar/#{hash}?d=mm&s=#{size}"
  end

  def password_required?
    false
  end
end
