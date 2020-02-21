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

    def policy(model)
      Pundit.policy(current_user, model)
    end

    def authorize(model, action)
      raise GraphQL::ExecutionError, "#{current_user&.name || 'Unauthenticated user'} is not allowed to #{action} this" unless policy(model).public_send(action)

      model
    end
  end
end
