class InvoicesController < ApplicationController
  before_action :load_invoice, except: :index

  def index
    @team = authorize Team.friendly.find(params[:team_id]), :show_financial?
  end

  def show
  end

  def update
    @invoice.close!
    redirect_to team_invoices_path(@invoice.team)
  end

  private

  def load_invoice
    @invoice = authorize Invoice.find(params[:id])
  end
end
