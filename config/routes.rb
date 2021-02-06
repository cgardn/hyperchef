Rails.application.routes.draw do

  # API v1
  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index, :show], param: :slug

      post '/auth', to: 'auths#create'
      post '/auth/admin', to: 'auths#create_admin'
      get '/auth/check', to: 'auths#check'
      get '/auth/check_admin', to: 'auths#check_admin'
      namespace :admin do
        resources :recipes
        resources :ingredients
        resources :ingredient_tags
        resources :recipe_types
        resources :equipment
      end
    end
  end
  
end
