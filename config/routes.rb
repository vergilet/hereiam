Rails.application.routes.draw do


  resources :topics do
    collection do
      post 'my_location'
    end
  	resources :messages
  end

  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
