module Types
  class MutationType < Types::BaseObject
    field :open_door, DoorType, null: true, description: "Open the specified door" do
      argument :id, String, required: true
    end
    def open_door(id:)
      Door.find(id).tap { |door| door.open! }
    end

    field :logout, Boolean, null: true
    def logout
      true
    end

    field :login_with_token, UserType, null: true do
      argument :token, String, required: true
    end
    def login_with_token(token:)
      context[:current_user]
    end
  end
end
