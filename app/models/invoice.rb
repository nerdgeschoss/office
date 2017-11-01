# == Schema Information
#
# Table name: invoices
#
#  id             :uuid             not null, primary key
#  team_id        :uuid             not null
#  invoiced_at    :datetime
#  total          :decimal(, )      not null
#  vat            :decimal(, )      not null
#  total_brut     :decimal(, )      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invoice_number :integer
#

class Invoice < ApplicationRecord
  belongs_to :team
  has_many :lines, class_name: "InvoiceLine", dependent: :destroy

  scope :open, -> { where(invoiced_at: nil) }
  scope :invoiced, -> { where.not(invoiced_at: nil) }

  before_validation do
    self.total = lines.sum(&:total)
    self.vat = lines.sum(&:vat_total)
    self.total_brut = total + vat
  end

  def invoiced?
    invoiced_at.present?
  end

  def close!
    return if invoiced? || total == 0
    Invoice.with_table_lock do
      update! invoiced_at: DateTime.current, invoice_number: (Invoice.maximum(:invoice_number) || 1) + 1
    end
  end

  def accounting_amount
    -(total + vat)
  end
end
