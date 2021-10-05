Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'users/edit'

  root 'tasks#index'
  resources :tasks
  # resources :labels, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit]
  get '/profil', to: 'users#show', as: :profil
  namespace :admin do
    resources :users
  end

  # namespace :admin do
  #   resources :users do
  #     collection do
  #       get "/role/:id", to: "users#role", as: "user_role"
  #     end
  #   end
  # end

end
