Rails.application.routes.draw do
  root "static_pages#home"

  resources :words, only: :index
  resources :users do
    get "/:relationship" => "relationships#index", as: :relationship,
      constraints: {relationship: /(following|followers)/}
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: :index
  resources :relationships, only: [:index, :create, :destroy]
  namespace :admin do
    root "users#index"
    resources :users
  end
end
