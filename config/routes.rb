Rails.application.routes.draw do
  # default to articles index
  root "articles#index"

  # omniauth github authentication routes
  # @TODO: @q9f integrate omniauth
  #get "/auth/github", as: "github_login"
  #get "/auth/:provider/callback", to: "sessions#update"

  # users and sessions routes
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  # articles and comments (nested) routes
  resources :articles do
    resources :comments
  end
end
