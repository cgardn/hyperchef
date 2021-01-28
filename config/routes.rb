Rails.application.routes.draw do

  # API v1
  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index, :show], param: :slug

      resource :auth, only: :create
      get '/auth/check', to: 'auths#check'
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
