# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id            :uuid             not null, primary key
#  user_id       :uuid
#  subject_type  :string
#  subject_id    :uuid
#  record_type   :string
#  record_id     :uuid
#  type          :string           not null
#  action        :string           not null
#  modifications :jsonb            not null
#  content       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Activity < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :subject, polymorphic: true, optional: true
  belongs_to :record, polymorphic: true, optional: true

  has_many :comments, as: :subject, dependent: :destroy

  scope :with_type, ->(type) { where(type: type) if type }
  scope :with_meta, ->(meta) { where("meta @> ?", meta.to_json) if meta }
end
