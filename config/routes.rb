Rails.application.routes.draw do
  
  root 'main_pages#home'
  get 'home'    => 'main_pages#home'
  get 'about'   => 'main_pages#about'
  get 'contact' => 'main_pages#contact'
  get 'signup' => 'users#new'
  get 'edit' => 'users#edit'

end
