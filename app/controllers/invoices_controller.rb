class InvoicesController < ApplicationController
  before_action :load_invoice

  def update
    @invoice.close!
    redirect_to @invoice.team
  end

  private

  def load_invoice
    @invoice = authorize Invoice.find(params[:id])
  end
end
