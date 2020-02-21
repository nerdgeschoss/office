# frozen_string_literal: true

source "https://rubygems.org"

# Core
gem "rails", "6.0.2"
gem "puma"

# Database
gem "pg"
gem "redis"

# IOT
gem "c_gpio", group: :development # prevent heroku from installing

# Extensions
gem "dotenv-rails"
gem "rails-i18n"
gem "active_model_serializers"
gem "rack-cors", require: "rack/cors"
gem "virtus", "< 2"
gem "oj"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "kaminari"
gem "slim"
gem "friendly_id"
gem "countries"
gem "pundit"
gem "document_serializable", "~> 0.2", git: "https://github.com/nerdgeschoss/document_serializable.git"
gem "devise"
gem "devise_invitable"
gem "http_accept_language"
gem "nested_form"
gem "groupdate"
gem "chartkick"
gem "time_for_a_boolean"
gem "graphql"
gem "pry-rails"
gem "graphiql-rails"
gem "bcrypt", "3.1.12" # newer version not supported on pi

# Assets
gem "sass-rails"
gem "jquery-rails"
gem "turbolinks"
gem "autoprefixer-rails"
gem "webpacker", require: false
gem "lodash-rails"
gem "rails-timeago"
gem "i18n-tasks"
gem "coffee-rails"

# Services
gem "newrelic_rpm"
gem "airbrake"
gem "aws-sdk-s3"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "spring-commands-rspec"
  gem "rubocop"
  gem "web-console"
  gem "annotate"
  gem "erd"
  gem "guard-livereload", require: false
  gem "rack-livereload"
  gem "rb-fsevent"
  gem "guard-rspec", require: false
  gem "oink"
  gem "letter_opener"
  gem "rack-mini-profiler"
end
