Rails.application.routes.draw do  
  resources :users

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'sign_in', to: 'user_sessions#new', as: 'sign_in'
  get 'sign_up', to: 'users#new', as: 'sign_up'

  resources :attendances do
    get 'new_permission', on: :collection
  end

  resources :companies

  resources :invitations

  resources :accept_invitations, only: [:new, :create]

  root 'attendances#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
