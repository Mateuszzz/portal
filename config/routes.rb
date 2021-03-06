Rails.application.routes.draw do
  
  root 'main_pages#home'

  get 'home'    => 'main_pages#home'
  get 'about'   => 'main_pages#about'
  get 'contact' => 'main_pages#contact'
  
  get 'signup' => 'users#new'
  resources :users do
    resources :friendships, only: [:create, :index, :update, :destroy]
  end
  
  resources :posts, only: [:create, :show, :destroy] do
    resources :comments, only: [:create]
  end
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
