Rails.application.routes.draw do
  devise_for :accounts
  root to: "public#index"
  # get "u/:username" => "public#profile", as: :profile
  
  # scope '/admin' do
  #   resources :accounts
  # end

  resources :accounts
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
