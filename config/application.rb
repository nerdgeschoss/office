# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Office
  class Application < Rails::Application
    config.load_defaults 5.1
    config.generators.system_tests = nil
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    config.autoload_paths << Rails.root.join("app", "policies")
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]

    config.action_mailer.default_url_options = { host: ENV["HOST"] } if ENV["HOST"].present?
    config.action_mailer.default_url_options = { host: "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" } if ENV["HEROKU_APP_NAME"].present?
  end
end
