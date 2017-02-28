Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :events, only: [:index] do
  	member do
  	  put 'generate_group'
  	end
  end

  resources :splitwises do
    collection do
      get 'analysis'
    end
  end
end
