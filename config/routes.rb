Rails.application.routes.draw do
  devise_for :users
  resources :teams
  resources :users
  root "kiosk#show"
end
