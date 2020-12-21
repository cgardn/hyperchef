Rails.application.routes.draw do
  resources :user_profiles, except: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'search#index'
  get '/search', to: 'search#query'

  get '/admin', to: 'admin#index'

  # API v1
  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index, :show], param: :slug
      # the new/edit views are handled in frontend as part of show, the
      #   api call will just be to auth the admin since all the ingredient
      #   data will already be there?
      resources :ingredients, except: [:new, :edit]
      resources :ingredient_tags, only: [:index, :create, :update, :destroy]
      resources :recipe_types, except: [:new, :edit, :show]

      resource :auth, only: :create
      get '/auth/check', to: 'auths#check'
      namespace :admin do
        resources :recipes
        #resources :ingredients
        resources :ingredient_tags
        #resources :recipe_types
      end
      # searching is done only on frontend for now
      #get '/text-search', action: :textSearch, controller: :recipes
      #get '/tag-search', action: :tagSearch, controller: :recipes
    end
  end

=begin
  get '/api/get_tags', to: 'api#get_tags'
=end

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
