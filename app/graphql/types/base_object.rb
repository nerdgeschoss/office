# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    protected

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

    def track_change(action, record = nil, subject: record, user: current_user, modifications: {})
      ChangeActivityJob.perform_later(
        action: action,
        user_id: current_user&.id,
        record_id: record&.id,
        record_type: record&.class&.base_class&.name,
        subject_id: subject&.id,
        subject_type: subject&.class&.base_class&.name,
        modifications: modifications
      )
    end
  end
end
