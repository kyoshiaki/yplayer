Rails.application.routes.draw do

  root 'directories#show'

  get 'sound_players/show'

  get 'directories/show'

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users 
  # resources :sounds, only: [:update, :destroy, :new, :edit, :show]
  resources :sounds

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
