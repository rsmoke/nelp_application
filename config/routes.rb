Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # namespace :admin do
  #     resources :logins
  #     resources :payments
  #     resources :users

  #     root to: "users#index"
  #   end
  # resources :transactions
  # get 'nelnet_services/payment_receipt'
  root 'pages#index'

  # get '/login', to: 'logins#create', as: :create_login
  # delete '/logout', to: 'logins#destroy'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms_of_service', to: 'pages#terms_of_service'

  get 'payments', to: 'payments#index'
  get 'payment_receipt', to: 'payments#payment_receipt'
  get 'payment_show', to: 'payments#payment_show', as: 'all_payments'
  get 'make_payment', to: 'payments#make_payment'
  post 'make_payment', to: 'payments#make_payment'

  # resources :users
end
