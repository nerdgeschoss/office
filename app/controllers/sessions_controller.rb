# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    if current_user
      redirect_to ENV.fetch("APP_URL").sub(":token", current_user.create_oauth_token)
    else
      authenticate_user!
    end
  end
end
