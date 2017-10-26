Rails.application.routes.draw do
  devise_for :users
  resources :teams
  resources :invoices
  resources :users
  resource :kiosk
  root "kiosks#show"
end
