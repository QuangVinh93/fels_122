Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
