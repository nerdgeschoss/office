# frozen_string_literal: true

class DevicePolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  private

  def owner?
    resource.user == user
  end
end
