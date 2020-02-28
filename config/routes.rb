Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'search#index'
  get '/search', to: 'search#query'
  get '/browse', to: 'search#browse'

  resources :recipes, except: [:create]
  post '/recipes', to: 'recipes#update'
  post '/recipes/:id', to: 'recipes#update'
  resources :ingredients, except: [:show]
  resources :actions
  resources :equipment
  resources :ingredient_tags
  
end
