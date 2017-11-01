Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    resources :subscriptions
    resources :payments, only: :create
    resources :invoices
  end
  resources :users
  resources :devices
  resources :products
  resource :kiosk
  root "kiosks#show"
end
