Rails.application.routes.draw do

  get 'wikis/index'

  get 'wikis/show'

  get 'wikis/new'

  get 'wikis/created'

  get 'wikis/edit'

  get 'wikis/update'

  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users, only: [:show]

  resources :wikis

  resources :subscriptions, only: [:new, :create]
  delete '/downgrade', to: 'subscriptions#downgrade'

  authenticated :user do
    root to: 'wikis#index', as: :authenticated_root
  end

  root 'home#index'




end
