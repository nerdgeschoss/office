class TeamsController < ApplicationController
  before_action :load_team, except: :index

  def index
    @teams = policy_scope(Team)
  end

  def show
  end

  private

  def load_team
    @team = authorize Team.friendly.find(params[:id])
  end
end
