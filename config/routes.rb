Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users, only: [:create, :show]
end
