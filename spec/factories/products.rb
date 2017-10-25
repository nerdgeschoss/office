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
#

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    available_in_kiosk true
    price { Faker::Commerce.price }
    vat_rate 19
    vat { price * vat_rate * 0.01 }
  end
end
