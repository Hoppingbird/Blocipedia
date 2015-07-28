Rails.application.routes.draw do


  get 'collaborators/new'

  get 'collaborators/create'

  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users, only: [:show]

  resources :wikis
  resources :collaborators

  resources :charges, only: [:new, :create]
  delete '/downgrade', to: 'charges#downgrade'

  authenticated :user do
    root to: 'wikis#index', as: :authenticated_root
  end

  root to: 'home#index'


end
