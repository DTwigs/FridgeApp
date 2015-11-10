Rails.application.routes.draw do
  root 'main#index'
  namespace :api do

    resources :temperature, only: %w(index)
    scope 'temperature', controller: :temperature do
      get :receive
    end
  end
end
