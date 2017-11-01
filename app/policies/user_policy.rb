class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    admin? || resource == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
