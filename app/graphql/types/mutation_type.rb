# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :open_door, DoorType, null: true, description: "Open the specified door" do
      argument :id, String, required: true
    end
    def open_door(id:)
      door = authorize Door.find(id), :open?
      track_change :open_front_door
      door.open!
      door
    end

    field :logout, Boolean, null: true
    def logout
      warden.logout
      true
    end

    field :login_with_token, UserType, null: true do
      argument :token, String, required: true
    end
    def login_with_token(token:)
      user = User.authenticate_with_token(token)
      warden.set_user user if user
      user
    end
  end
end
