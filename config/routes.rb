Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'grid', to: "decorated_grids#show"

  resources :decorated_grids, path: "grid"
end
