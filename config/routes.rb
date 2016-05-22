Rails.application.routes.draw do

  get 'sessions/new'

  get 'users/new'

  root "static_pages#home"

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/help'
  
  get 'signup'  => 'users#new'
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users

end
