class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create]

  def index
    @users = policy_scope(User).without_role(:kiosk).alphabetical
  end

  def show
    @presence_month = DateTime.current + params[:month].to_i.months
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
    @user = authorize User.new invite_params
    if @user.save
      @user.invite!(current_user)
      redirect_to @user
    else
      index
      render :index
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def load_user
    @user = authorize User.friendly.find(params[:id])
  end

  def invite_params
    params.require(:user).permit(:first_name, :last_name, :email, :team_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :archived, :password_confirmation)
  end
end
