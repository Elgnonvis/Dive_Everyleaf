Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :labels
  resources :sessions, only: [:new, :create, :destroy]
 
  
  resources :users, only: [:new, :create, :edit, :update]
  get '/profil', to: 'users#show', as: :profil
  namespace :admin do
    resources :users
  end
 # resources :labels, only: [:new, :create]
  # namespace :admin do
  #   resources :users do
  #     collection do
  #       get "/role/:id", to: "users#role", as: "user_role"
  #     end
  #   end
  # end

end
