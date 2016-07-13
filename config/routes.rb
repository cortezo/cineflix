Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  resources :videos, only: [:show] do
    collection do
      # Always use Get for search forms.  This allows people to bookmark a search.
      get :search, to: 'videos#search'
    end
  end

  resources :categories, only: [:index, :show]

  resources :sessions, only: [:new, :create]

  resources :users, only: [:create]

  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
end
