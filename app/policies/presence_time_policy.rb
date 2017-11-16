class PresenceTimePolicy < ApplicationPolicy
  def show?
    admin? || user.id == resource.user_id
  end
end
