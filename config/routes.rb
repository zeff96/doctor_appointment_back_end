Rails.application.routes.draw do
  get 'tokens/create'
  get 'tokens/verify'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root "doctors#index"
  resources :doctors do
    resources :appointments, only: %i[new create index]
  end
end
