Rails.application.routes.draw do
  root 'submissions#index'
  resources :communities

  resources :submissions do
    resources :comments
  end

  devise_for :users
end
