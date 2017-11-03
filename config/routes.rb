Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    resources :subscriptions
    resources :payments, only: :create
    resources :invoices
  end
  resources :invoice_lines
  resources :users
  resources :devices
  resources :products
  resource :kiosk

  namespace :api do
    namespace :hooks do
      post "online_devices", to: "devices#online"
    end
  end

  root "dashboards#show"
end
