Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'incoming_emails#index'
  resources :incoming_emails, only: %i[new create index show]
  resources :customers, only: %i[index show]
  resources :email_processings, only: %i[index show]
end
