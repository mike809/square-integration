Rails.application.routes.draw do
  get '/' => 'merchant#new'
  post '/merchant' => 'merchant#create'
  get '/callback' => 'merchant#callback'

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
