Rails.application.routes.draw do
  get 'git/pull'

  root 'booths#index'
  resources :booths, only: [:index, :show, :edit, :update]

  resources :booths, only: [:index, :show, :update], path: 'api/v1/booths', format: 'json'
end
