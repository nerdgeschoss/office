class InvoiceLinePolicy < ApplicationPolicy
  def destroy?
    admin? || resource.invoice.team_id == user.team_id && resource.created_at > DateTime.current.beginning_of_day && resource.product.available_in_kiosk?
  end
end
