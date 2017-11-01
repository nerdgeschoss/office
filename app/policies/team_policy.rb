class TeamPolicy < ApplicationPolicy
  def show?
    true
  end

  def show_financial?
    admin? || member?
  end

  def financial_overview?
    admin?
  end

  def member?
    user.team_id == resource.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
