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

require "rails_helper"

RSpec.describe User, type: :model do
end
