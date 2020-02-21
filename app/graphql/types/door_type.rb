# frozen_string_literal: true

# frozen_string_literal: true

module Types
  class DoorType < Types::BaseObject
    field :id, ID, null: false
    field :buzzing, Boolean, null: true, method: :buzzing?
  end
end
