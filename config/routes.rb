Rails.application.routes.draw do
  root "doctors#index"
  resources :doctors
end
