Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
end
