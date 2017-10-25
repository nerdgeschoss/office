Rails.application.routes.draw do
  devise_for :users
  root "kiosk#show"
end
