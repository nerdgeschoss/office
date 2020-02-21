# frozen_string_literal: true

class DoorPolicy < ApplicationPolicy
  def show?
    logged_in?
  end

  def open?
    logged_in?
  end
end
