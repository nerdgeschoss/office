class TeamsController < ApplicationController
  before_action :load_team, except: [:index, :create]

  def index
    @teams = policy_scope(Team)
  end

  def show
  end

  def create
    @team = authorize Team.new team_params
    if @team.save
      redirect_to @team
    else
      index
      render :index
    end
  end

  def update
    @team.assign_attributes team_params
    if @team.save
      redirect_to @team
    else
      render :show
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
