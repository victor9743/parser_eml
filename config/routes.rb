Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'incoming_emails#index'
  resources :incoming_emails, only: [:new, :create, :index, :show]
  resources :customers, only: [:index, :show]
  resources :email_processings, only: [:index, :show]

end
