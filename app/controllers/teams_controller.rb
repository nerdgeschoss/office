# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :load_team, except: [:index, :new, :create]

  def index
    @teams = policy_scope(Team).includes(:invoices, :payments, :users)
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = authorize Team.new team_params
    if @team.save
      navigate_to @team
    else
      render_modal :new
    end
  end

  def edit
  end

  def update
    if @team.update team_params
      close_modal
    else
      render_modal :edit
    end
  end

  private

  def load_team
    @team = authorize Team.friendly.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :website)
  end
end
