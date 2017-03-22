Rails.application.routes.draw do
  namespace :admin do
    resources :merchant_locations, only: [:index, :show]
    resources :merchant_transactions, only: [:index, :show]
    resources :merchants, only: [:index, :show]
  end

  get '/' => 'merchant#new'
  post '/merchant' => 'merchant#create'
  get '/callback' => 'merchant#callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
