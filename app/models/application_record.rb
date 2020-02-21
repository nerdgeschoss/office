# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def required_attributes
      @required_attributes ||= validators
        .select { |e| e.is_a? ActiveModel::Validations::PresenceValidator }
        .flat_map(&:attributes)
        .uniq
    end
  end
end
