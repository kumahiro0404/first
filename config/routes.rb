Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'posts/home'
  root 'posts#home'
  devise_for :users
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
 resources :users, only: [:show ,:index]
 
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]

  end

  
  resources :diaries
  

end
