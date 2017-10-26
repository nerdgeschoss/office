class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  layout :determine_layout
  before_action :authenticate_user!
  before_action :set_locale
  before_action :track_activity

  private

  def set_locale
    I18n.locale = params[:locale].presence || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def default_url_options
    return { locale: params[:locale] } if params[:locale].present?
    {}
  end

  def current_device
    return unless current_user
    @current_device ||= begin
      device = nil
      if session[:device_id].nil?
        device = current_user.devices.create! user_agent: request.user_agent
        session[:device_id] = device.id
      else
        device = current_user.devices.find_by(id: session[:device_id])
      end
      device
    end
  end

  def track_activity
    current_device&.touch(:last_activity_at)
  end

  def determine_layout
    return "authentication" if devise_controller?
    "application"
  end
end
