Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users do
    get "/:relationship" => "relationships#index", as: :relationship,
      constraints: {relationship: /(following|followers)/}
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: [:index, :new, :create]
  resources :relationships, only: [:index, :create, :destroy]
  namespace :admin do
    root "categories#index"
    resources :users
    resources :categories, except: :show
  end
  resources :lessons, only: [:update, :create, :show]
end
