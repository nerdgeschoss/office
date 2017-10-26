class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create]

  def index
    @users = policy_scope(User)
  end

  def show
  end

  def update
    @user.assign_attributes user_params
    if @user.save
      redirect_to @user
    else
      render :show
    end
  end

  def create
    @user = authorize User.new user_params
    if @user.save
      redirect_to @user
    else
      index
      render :index
    end
  end

  private

  def load_user
    @user = authorize User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :team_id, :password, :password_confirmation)
  end
end
