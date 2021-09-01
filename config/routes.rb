Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  get 'users/new'
  get 'users/create'
  root "articles#index"

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sessions#update"

  resources :articles do
    resources :comments
  end
end
