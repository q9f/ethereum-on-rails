Rails.application.routes.draw do
  # default to articles index
  root "articles#index"

  # omniauth github authentication routes
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sessions#update"

  # users and sessions routes
  resources :users
  resources :sessions

  # articles and comments (nested) routes
  resources :articles do
    resources :comments
  end
end
