Rails.application.routes.draw do
  # default to sessions/landing
  root 'sessions#landing'

  # user routes
  resources :users, only: [:new, :create]

  # session routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'
end
