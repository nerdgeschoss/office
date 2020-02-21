# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :load_subscription, except: [:index, :create]

  def index
    @team = team
  end

  def create
    @subscription = authorize team.subscriptions.new subscription_params
    if @subscription.save
      redirect_to team_subscriptions_path(team)
    else
      render :index
    end
  end

  private

  def team
    @team ||= Team.friendly.find(params[:team_id])
  end

  def subscription_params
    params.require(:subscription).permit(:quantity, :product_id, :next_renewal_at)
  end
end
