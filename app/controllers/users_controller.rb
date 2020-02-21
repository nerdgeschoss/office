# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  def new
    @user = User.new
  end

  def index
    @users = policy_scope(User).without_role(:kiosk).alphabetical
  end

  def show
    @presence_month = DateTime.current + params[:month].to_i.months
  end

  def edit
  end

  def update
    @user.assign_attributes user_params
    if @user.save
      close_modal
    else
      render_modal :edit
    end
  end

  def create
    @user = authorize User.new invite_params
    if @user.save
      @user.invite!(current_user)
      navigate_to @user
    else
      render_modal :new
    end
  end

  def destroy
    @user.destroy
    navigate_to users_path
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
