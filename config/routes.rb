Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    member do
      get :likesDisplay
    end
  end

  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    collection do
      get :search
    end
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"

end
