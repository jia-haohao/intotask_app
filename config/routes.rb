Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    root 'admin/users#index'
    resources :users
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
