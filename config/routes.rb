Rails.application.routes.draw do
  get 'nelnet_services/payment_receipt'
  root 'pages#index'
  # resources :sessions
  # get '/login', to: 'logins#new'
  get '/login', to: 'logins#create', as: :create_login
  # get 'pages/index'
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms_of_use', to: 'pages#terms_of_use'

  get 'payment_receipt', to: 'nelnet_services#payment_receipt'
  get 'make_payment', to: 'nelnet_services#make_payment'
  # get '/login', to: 'sessions#new'

  # post '/login', to: 'sessions#create'

  delete '/logout', to: 'logins#destroy'

  resources :users
end
