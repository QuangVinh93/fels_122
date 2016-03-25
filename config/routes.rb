Rails.application.routes.draw do
  root "static_pages#home"
  delete "logout" => "sessions#destroy"

  resources :words, only: :index
  resources :lessons, only: :index
  resources :users do
    get "/:relationship" => "relationships#index", as: :relationship,
      constraints: {relationship: /(following|followers)/}
  end
  resources :sessions, only: [:new, :create]
  resources :categories, only: [:index, :new, :create]
  resources :relationships, only: [:index, :create, :destroy]
  namespace :admin do
    root "categories#index"
    resources :users
    resources :categories, except: :show
    resources :words, only: [:new, :create]
  end
  resources :lessons, except: [:index, :destroy, :edit]
end
