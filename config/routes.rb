Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'tokens/create'
  get 'tokens/verify'
  devise_for :users, path: '', path_names: {
    sign_in: '/login',
    sign_out: '/logout',
    registration: '/signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root "doctors#index"
  resources :doctors do
    resources :appointments, only: %i[new create index destroy]
  end
end
