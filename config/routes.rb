Rails.application.routes.draw do
  
  get 'sessions/new'

  root 'main_pages#home'
  
  get 'home'    => 'main_pages#home'
  get 'about'   => 'main_pages#about'
  get 'contact' => 'main_pages#contact'
  
  get 'signup' => 'users#new'
  resources :users
  
  resources :posts, only: [:create, :show, :destroy]
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
