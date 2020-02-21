# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      User.find_by(email: username)&.valid_passwort?(password)
    end
  end
  mount Sidekiq::Web => "/sidekiq"
  post "/graphql", to: "graphql#execute"
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  devise_for :users

  resources :teams do
    resources :subscriptions
    resources :payments, only: :create
    resources :invoices
  end
  resources :invoice_lines
  resources :users do
    resources :presence_times, only: :index
  end
  resources :devices
  resources :products
  resource :kiosk

  resources :doors, only: [] do
    post "open", on: :member
  end

  namespace :api do
    namespace :hooks do
      post "online_devices", to: "devices#online"
    end
  end

  get "app-login", to: "sessions#new"

  root "dashboards#show"
end
