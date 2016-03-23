Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: :index
end
