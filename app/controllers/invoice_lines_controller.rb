class InvoiceLinesController < ApplicationController
  def destroy
    line = authorize InvoiceLine.find(params[:id])
    line.destroy
    line.invoice.save
    redirect_to team_invoices_path(line.invoice.team)
  end
end
