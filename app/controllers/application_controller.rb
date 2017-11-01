class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  layout :determine_layout
  before_action :authenticate_user!
  before_action :set_locale
  before_action :track_activity
  before_action :redirect_kiosk

  private

  def set_locale
    I18n.locale = params[:locale].presence || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def default_url_options
    return { locale: params[:locale] } if params[:locale].present?
    {}
  end

  def track_activity
    current_user&.touch(:last_activity_at)
  end

  def determine_layout
    return "authentication" if devise_controller?
    return "kiosk" if current_user&.kiosk?
    "application"
  end

  def redirect_kiosk
    redirect_to kiosk_path if current_user&.kiosk? && controller_name != "kiosks"
  end
end
