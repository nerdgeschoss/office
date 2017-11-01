class KioskPolicy < ApplicationPolicy
  def show?
    admin? || kiosk?
  end

  def create?
    admin? || kiosk?
  end
end
