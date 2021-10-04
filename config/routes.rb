Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'users/edit'
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
end
