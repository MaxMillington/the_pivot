Rails.application.routes.draw do
  root to: "static_pages#index"

  resources :products, only: [:index, :show]
  resources :categories, param: :slug, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :addresses, only: [:new, :update, :create]
  resources :categories, param: :slug, only: [:index,:show]
  resources :auctions, only: [:index, :show]
  resources :bids, only: [:index,:show,:new,:create,:edit,:update]
  resources :addresses, only: [:new,:create,:edit,:update]



  get "/profile",    to: "users#show"
  get "/my-bids",   to: "users#feed"
  patch "/profile",    to: "users#update"
  post "/profile",     to: "users#create"
  get "/profile/new",  to: "users#new"
  get "/profile/edit", to: "users#edit"

  get "/login",        to: "sessions#new"
  post "/login",       to: "sessions#create"
  delete "/logout",    to: "sessions#destroy"

  namespace :sellers, path: ':seller', as: :seller do
    get '/', to: 'products#index'
    resources :categories, param: :slug, only: [:show]

    namespace :admin do
      resources :products

      get "/",           to: "admins#index"
      get "/dashboard",  to: "admins#index"

    end
  end

  namespace :super_admin do
    resources :products
    resources :users
    resources :sellers
    resources :orders, only: [:index, :show, :update]

    get "/",           to: "admins#index"
    get "/dashboard",  to: "admins#index"
   end

  resources :charges

  post "twilio/connect_customer" => "twilio#connect_customer"
end
