Rails.application.routes.draw do  
  resources :users

  resources :user_sessions, only: [:new, :create, :destroy]
  get 'sign_in', to: 'user_sessions#new', as: 'sign_in'
  get 'sign_up', to: 'users#new', as: 'sign_up'

  resources :attendances do
    get 'new_permission', on: :collection
  end

  resources :companies

  resources :invitations, only: [:new, :create, :edit, :update]

  resources :accept_invitations, only: [:edit, :update], param: :invite_token
  get 'accept_invitations/:invite_token', to: 'accept_invitations#edit', as: 'accept_invitations'

  resources :passwords, only: [:new, :create, :edit, :update], param: :reset_password_token
  get 'forgot_password', to: 'passwords#new', as: 'forgot_password'
  get 'reset_password/:reset_password_token', to: 'passwords#edit', as: 'reset_password'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users
    resources :companies
    resources :attendances, only: [:index, :show]
  end

  root 'attendances#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
