Rails.application.routes.draw do
  get 'pages/index'
  get 'pages/about'
  get 'pages/contact'
  get 'pages/privacy'
  get 'pages/terms_of_use'
  resources :logins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
