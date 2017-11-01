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

class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :invoices, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true

  def open_invoice
    invoices.open.first_or_create
  end

  def invoices_and_payments
    (invoices.invoiced + payments).select(&:persisted?).sort_by(&:created_at)
  end

  def balance
    payments.sum(&:amount) - invoices.sum(&:total)
  end
end
