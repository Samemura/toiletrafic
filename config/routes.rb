Rails.application.routes.draw do
  root 'booths#index'
  resources :booths, only: [:index]

  resources :booths, only: [:index, :show, :update], path: 'api/v1/booths', format: 'json'
end
