Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    resources :subscriptions
    resources :payments, only: :create
  end
  resources :invoices
  resources :users
  resources :devices
  resource :kiosk
  root "kiosks#show"
end
