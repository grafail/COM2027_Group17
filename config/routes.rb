Rails.application.routes.draw do

  get 'cart', to: 'cart#cart'
  resources :purchases
  resources :orders
  get 'home/home'
  get '/home', to: redirect('/')
  resources :tickets
  resources :events
  devise_for :users
  root 'home#home'
  get 'cart/empty', to: 'cart#clear'
  get 'cart/add/:id/:qty', to: 'cart#add', as: :cart_add
  get 'cart/remove/:id', to: 'cart#remove', as: :cart_remove

  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
