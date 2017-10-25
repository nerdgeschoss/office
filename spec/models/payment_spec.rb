# == Schema Information
#
# Table name: payments
#
#  id         :uuid             not null, primary key
#  team_id    :uuid             not null
#  amount     :decimal(, )      not null
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Payment, type: :model do
end
