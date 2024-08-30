Rails.application.routes.draw do
  get 'profiles/show'
  root 'submissions#index'
  resources :communities

  resources :submissions do
    resources :comments
  end

  devise_for :users

  resources :profiles, only: [:show]
end
