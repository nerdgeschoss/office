# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def current_user
      context[:current_user]
    end

    def warden
      context[:request].env["warden"]
    end
  end
end
