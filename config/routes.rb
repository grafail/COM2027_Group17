Rails.application.routes.draw do

  get 'checkout', to: 'checkout#index'
  get 'cart', to: 'cart#cart'
  resources :purchases
  resources :orders
  resources :tickets
  resources :events
  get 'home/home'
  get '/home', to: redirect('/')
  get '/users', to: redirect('/')
  Rails.application.routes.draw do
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }
  end

  root 'home#home'
  get 'cart/empty', to: 'cart#clear'
  get 'cart/change/:id/:qty', to: 'cart#change_qty', as: :cart_change_qty
  get 'cart/remove/:id', to: 'cart#remove', as: :cart_remove

  get 'ticket/delete/:id', to: 'tickets#destroy', as: :ticket_delete

  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  post 'checkout', to: 'checkout#payment', as: :complete_payment

  get 'about', to: 'home#about'
  get 'privacy', to: 'home#privacy'
  get 'termsandconditions', to: 'home#termsandconditions'
  get 'tickets/list/:id', to:'tickets#list', as: :ticket_list
  get 'events/list/:id', to:'events#list', as: :event_list

  get 'myevents', to: 'events#myEvents'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
