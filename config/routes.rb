Rails.application.routes.draw do

  root 'home#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :events, only: [:index]
end
