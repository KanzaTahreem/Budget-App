Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :splash, only: [:index]
  resources :groups do
    resources :expenses
  end

  resources :not_found, only: [:index]
  # Defines the root path route ("/")
  # root "articles#index"
  root 'splash#index'

  get '/unauthorized', to: 'unauthorized#index'

  match '*unmatched', to: 'application#not_found_method', via: :all, constraints: ->(req) do
    req.path.exclude? 'rails/active_storage'
  end
end
