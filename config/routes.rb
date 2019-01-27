Rails.application.routes.draw do
  namespace :admin do
      resources :logins
      resources :payments
      resources :users

      root to: "users#index"
    end
  resources :transactions
  # get 'nelnet_services/payment_receipt'
  root 'pages#index'

  get '/login', to: 'logins#create', as: :create_login
  delete '/logout', to: 'logins#destroy'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms_of_service', to: 'pages#terms_of_service'

  get 'payment_receipt', to: 'payments#payment_receipt'
  get 'make_payment', to: 'payments#make_payment'
  post 'make_payment', to: 'payments#make_payment'

  resources :users
end
