# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :me, UserType, description: "The current user object", null: true
    def me
      context[:current_user]
    end

    field :door, DoorType, null: true, description: "Retrieve a door by slug" do
      argument :id, String, required: true
    end
    def door(id:)
      Door.find(id)
    end
  end
end
