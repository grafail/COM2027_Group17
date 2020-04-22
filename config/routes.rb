Rails.application.routes.draw do

  get 'home/home'
  get '/home', to: redirect('/')
  resources :purchases
  resources :tickets
  resources :events
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      } 
  root 'home#home'

  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
