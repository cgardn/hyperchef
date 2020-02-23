Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'search#index'
  get '/search', to: 'search#query'

  resources :recipes, only: [:index, :show]
  resources :ingredients, except: [:show]
  resources :actions
  resources :equipment
  resources :ingredient_tags
  
end
