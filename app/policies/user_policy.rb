class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    admin? || resource == user
  end

  def show_presence?
    admin? || resource == user
  end

  def destroy?
    super && resource != user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
