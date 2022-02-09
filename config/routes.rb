Rails.application.routes.draw do

  # ethereum authentication demo
  root "pages#demo"

  # authentication logic routes
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post "logout", to: "sessions#destroy"
  get "logout", to: "sessions#destroy"

  # api to fetch nonces for users
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
