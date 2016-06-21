Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'categories#index'

  resources :videos, only: [:show] do
    collection do
      # Always use Get for search forms.  This allows people to bookmark a search.
      get :search, to: 'videos#search'
    end
  end

  resources :categories, only: [:index, :show]
end
