Rails.application.routes.draw do
  devise_for :users
  root "doctors#index"
  resources :doctors do
    resources :appointments, only: %i[new create index]
  end
end
