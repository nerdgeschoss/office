class MenuItemPolicy < ApplicationPolicy
  def show?
    send "#{resource.slug}?"
  end

  def dashboard?
    true
  end

  def kiosk?
    true
  end

  def teams?
    admin?
  end

  def users?
    admin?
  end
end
