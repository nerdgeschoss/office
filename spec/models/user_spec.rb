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
#

require "rails_helper"

RSpec.describe User, type: :model do
end
