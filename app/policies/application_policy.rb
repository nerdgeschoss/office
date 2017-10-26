class ApplicationPolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  delegate :admin?, to: :user, allow_nil: true

  def scope
    user.team
  end

  class Scope
    attr_reader :user, :scope, :company

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    delegate :team, to: :role, allow_nil: true
  end
end
