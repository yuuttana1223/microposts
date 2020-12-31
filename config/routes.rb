Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      # Prefix Verb   URI Pattern                     Controller#Action
      # followings_user GET    /users/:id/followings(.:format) users#followings
      # followers_user GET    /users/:id/followers(.:format)  users#followers
      get :followings
      get :followers
    # collection do
      # get :serchch
    #   /users/search のように :id が含まれない URL を生成
    # end
    end
  end

  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
