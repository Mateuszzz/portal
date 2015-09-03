Rails.application.routes.draw do
  
  get 'main_pages/home'

  get 'main_pages/about'

  get 'main_pages/contact'
  
  root 'main_pages#home'

end
