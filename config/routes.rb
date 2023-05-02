Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root "articles#index"

  resources :articles, except: [:destroy]
  resources :order_items, only: [:create, :destroy]
  resources :orders do
    get '/current', to: 'orders#current', on: :collection
    resources :checkout, only: [:create]
    get '/checkout', to: 'orders#checkout'
  end

  get 'profile', to: 'users#profile'

  post '/webhook', to:'webhook#receive'
end
