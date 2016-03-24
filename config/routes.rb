Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users, except: [:destroy] do
    member do
      get :followers, :following
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: :index
  resources :relationships, only: [:create, :destroy]
end
