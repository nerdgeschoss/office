class MenuItemPolicy < ApplicationPolicy
  def show?
    send "#{resource.slug}?"
  end

  def dashboard?
    true
  end

  def kiosk?
    admin?
  end

  def products?
    admin?
  end

  def teams?
    true
  end

  def users?
    true
  end
end
