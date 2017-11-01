class PaymentsController < ApplicationController
  def create
    @team = Team.friendly.find(params[:team_id])
    @payment = authorize @team.payments.build payment_params
    if @payment.save
      redirect_to @team
    else
      render "teams/show"
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :subject, :created_at)
  end
end
