Rails.application.routes.draw do
  root 'booths#index'
  resources :booths, only: [:index]

end
