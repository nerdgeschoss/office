# frozen_string_literal: true

Rails.application.routes.draw do
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
