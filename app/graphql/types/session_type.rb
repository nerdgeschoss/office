# frozen_string_literal: true

module Types
  class SessionType < Types::BaseObject
    field :user, UserType, null: false
  end
end
