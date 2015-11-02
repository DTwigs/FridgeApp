Rails.application.routes.draw do
  root 'main#index'
  namespace :api do
    resources :temperature
  end
end
