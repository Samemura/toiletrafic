Rails.application.routes.draw do
  resources :booths, only: [:index]
  root 'booths#index'

end
