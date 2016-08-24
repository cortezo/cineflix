Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  resources :videos, only: [:show] do
    collection do
      # Always use Get for search forms.  This allows people to bookmark a search.
      get :search, to: 'videos#search'
    end

    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]

  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'home', to: "categories#index"
  get 'logout', to: "sessions#destroy"
  post 'login', to: "sessions#create"
end
