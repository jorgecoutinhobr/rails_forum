Rails.application.routes.draw do
  get 'profiles/show'
  root 'submissions#index'
  resources :communities

  resources :submissions do
    member do
      put "upvote", to: "submissions#upvote"
      put "downvote", to: "submissions#downvote"
    end

    resources :comments do
      member do
        put "upvote", to: "comments#upvote"
        put "downvote", to: "comments#downvote"
      end
    end
  end

  devise_for :users

  resources :profiles, only: [:show]


end
