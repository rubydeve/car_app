Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do
      get :register
      get :login
      post :user_login
      post :user_register
      get  :logout
    end
  end
  resources :cars
  resources :drivers
  resources :dashboard ,only: [:index]
  resources :agreements
  resources :expenses
  resources :reports 

  resources :profiles

  get "profile" , to: "profiles#onwer" ,as: :onwer_profile

  root "users#login"


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        collection do
          post :user_login
          post :user_register
          get  :logout
        end
      end
      resources :cars
      resources :expenses
      resources :agreements
      resources :drivers
      resources :dashboard ,only: [:index] do 
        collection do
          get :earning
          get :expense
          get :profit
          get :unpaid_agreement
          get :agreement_this_month
        end
      end
      resources :reports
    end
  end


end
