# frozen_string_literal: true

class InvoicePolicy < ApplicationPolicy
  def show?
    admin? || user.team_id == resource.team_id
  end
end
