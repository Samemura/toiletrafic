Rails.application.routes.draw do
  root 'booths#index'
  resources :booths, only: [:index, :show, :update], path: 'api/v1/booths', format: 'json'
  resources :toilets, only: [:index, :show], path: 'api/v1/toilets', format: 'json'

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #TODO: only for testsite. to be removed for production.
  get 'git/pull'
end
