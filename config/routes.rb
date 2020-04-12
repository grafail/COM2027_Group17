Rails.application.routes.draw do
  get 'home/home'
  resources :purchases
  resources :tickets
  resources :events
  devise_for :users
  root 'home#home'

  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
