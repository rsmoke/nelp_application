Rails.application.routes.draw do
  resources :users
  root to: 'pages#index'
  resources :sessions
  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login
  get 'pages/index'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/privacy'
  get 'pages/terms_of_use'
  #resources :logins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
