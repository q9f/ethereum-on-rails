Rails.application.routes.draw do
  root "articles#index"

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sessions#update"

  resources :articles do
    resources :comments
  end

end
