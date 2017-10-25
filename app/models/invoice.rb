# == Schema Information
#
# Table name: invoices
#
#  id          :uuid             not null, primary key
#  team_id     :uuid             not null
#  invoiced_at :datetime
#  total       :decimal(, )      not null
#  vat         :decimal(, )      not null
#  total_brut  :decimal(, )      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Invoice < ApplicationRecord
  belongs_to :team
  has_many :lines, class_name: "InvoiceLine", dependent: :destroy

  before_validation do
    self.total = lines.to_a.sum(:total)
    self.vat = lines.to_a.sum(:vat)
    self.total_brut = total + vat
  end
end
