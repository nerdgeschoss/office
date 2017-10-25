class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :determine_layout
  before_action :authenticate_user!
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale].presence || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def default_url_options
    return { locale: params[:locale] } if params[:locale].present?
    {}
  end

  def determine_layout
    return "authentication" if devise_controller?
    "application"
  end
end
