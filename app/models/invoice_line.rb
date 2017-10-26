# == Schema Information
#
# Table name: invoice_lines
#
#  id            :uuid             not null, primary key
#  product_id    :uuid             not null
#  price         :decimal(, )      not null
#  vat           :decimal(, )      not null
#  vat_rate      :decimal(, )      not null
#  ordered_by_id :uuid
#  invoice_id    :uuid             not null
#  quantity      :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class InvoiceLine < ApplicationRecord
  belongs_to :product
  belongs_to :invoice
  belongs_to :user, foreign_key: :ordered_by_id, required: false

  before_validation do
    self.price ||= product.price
    self.vat ||= product.vat
    self.vat_rate ||= product.vat_rate
  end

  def total
    price * quantity
  end

  def vat_total
    vat * quantity
  end

  after_save do
    invoice.save
  end
end
