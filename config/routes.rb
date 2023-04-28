Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles, except: [:destroy]
  resources :order_items, only: [:create]
  resources :orders do
    get '/current', to: 'orders#current', on: :collection
    resources :checkout, only: [:create]
    get '/checkout', to: 'orders#checkout'
  end

  post '/webhook', to:'webhook#receive'
end
