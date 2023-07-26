Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
    sign_in: '/login',
    sign_out: '/logout',
    registration: '/signup',
    password: '/reset_password'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root "doctors#index"
  resources :doctors do
    resources :appointments, only: %i[new create index destroy]
  end

  resources :appointments, only: [:index]
end
