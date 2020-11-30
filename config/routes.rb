Rails.application.routes.draw do
  resources :user_profiles, except: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'search#index'
  get '/search', to: 'search#query'

  get '/admin', to: 'admin#index'

  # API endpoints
  get '/api/test', to: 'api#test'
  get '/api/all', to: 'api#all'
  get '/api/search', to: 'api#search'
  get '/api/:slug', to: 'api#single'


  resources :recipes, except: [:create, :index], param: :slug
  get '/recipes', to: 'search#query'
  post '/recipes', to: 'recipes#update'
  post '/recipes/:slug', to: 'recipes#update'

  post '/user_profiles/favorites/:id', to: 'user_profiles#add_favorite_recipe'
  delete '/user_profiles/favorites/:id', to: 'user_profiles#remove_favorite_recipe'

  resources :ingredients, except: [:show]
  post '/ingredients/:id', to: 'ingredients#update'
  resources :equipment, except: [:index, :show]
  resources :ingredient_tags
  resources :recipe_types
  
end
