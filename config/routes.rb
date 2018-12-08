Rails.application.routes.draw do
  resources :transactions
  # get 'nelnet_services/payment_receipt'
  root 'pages#index'

  get '/login', to: 'logins#create', as: :create_login
  delete '/logout', to: 'logins#destroy'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms_of_service', to: 'pages#terms_of_service'

  get 'payment_receipt', to: 'nelnet_services#payment_receipt'
  get 'make_payment', to: 'nelnet_services#make_payment'

  resources :users
end
