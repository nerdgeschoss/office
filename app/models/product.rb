# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                 :uuid             not null, primary key
#  name               :string           not null
#  slug               :string           not null
#  available_in_kiosk :boolean          default(FALSE), not null
#  price              :decimal(, )      not null
#  vat                :decimal(, )      not null
#  vat_rate           :decimal(, )      not null
#  deprecated         :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :bigint
#  image_updated_at   :datetime
#

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, styles: { medium: "256x256>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}

  scope :available_in_kiosk, -> { where(available_in_kiosk: true, deprecated: false) }
  scope :active, -> { where(deprecated: false) }
  scope :alphabetical, -> { order(name: :asc) }

  has_many :invoice_lines, dependent: :destroy

  validates :name, :price, :vat, :vat_rate, presence: true
end
