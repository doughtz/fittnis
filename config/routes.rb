Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'
  
  get 'videos/new'
  
  get 'videos/index'

  root "static_pages#home"

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/help'
  
  get 'signup'  => 'users#new'
  
  get  'upload' => 'videos#new'
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get '/users/increase_workoutseconds', to: 'users#increase_workoutseconds'
  get '/users/increase_workouts', to: 'users#increase_workouts'
  resources :users
  resources :videos
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
