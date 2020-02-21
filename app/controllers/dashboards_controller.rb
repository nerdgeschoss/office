# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @recent_purchases = current_user.invoice_lines.today
    @currently_in_office = User.in_office
    @door = Door.find(:front)
  end
end
