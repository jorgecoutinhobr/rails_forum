Rails.application.routes.draw do
  root 'submissions#index'

  resources :communities do
    resources :subscriptions
  end

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
