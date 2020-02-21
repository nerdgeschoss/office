# frozen_string_literal: true

# frozen_string_literal: true

module Types
  class TeamType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :website, String, null: true
    field :slug, String, null: false
    field :users, UserType.connection_type, null: false
  end
end
