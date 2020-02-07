class ApplicationPolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  delegate :admin?, :kiosk?, to: :user, allow_nil: true

  def show?
    admin?
  end

  def edit?
    update?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  class Scope
    attr_reader :user, :scope, :company

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      return scope.all if admin?
      scope.none
    end

    delegate :team, :admin?, to: :user, allow_nil: true
  end
end
