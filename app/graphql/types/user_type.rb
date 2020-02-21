# frozen_string_literal: true

# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :name, String, null: false
    field :slug, String, null: false
    field :team, TeamType, null: false
    field :in_office, Boolean, null: false, method: :in_office?
    field :last_time_in_office, GraphQL::Types::ISO8601DateTime, null: true
    field :avatar_url, String, null: false
  end
end
