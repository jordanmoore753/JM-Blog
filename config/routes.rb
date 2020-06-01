Rails.application.routes.draw do
  get '/login',     to: 'sessions#new'
  get '/signup',    to: 'users#new'
  get '/profile',   to: 'users#show'
  get '/edit',      to: 'users#edit'
  post '/signup',   to: 'users#create'
  post '/login',    to: 'sessions#create'
  patch '/edit',    to: 'users#update'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
