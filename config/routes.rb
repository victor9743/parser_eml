Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'incoming_emails#new'
  resources :incoming_emails, only: [:new, :create, :index, :show] do
    member do
      post :reprocess
    end
  end
  resources :customers, only: [:index, :show]
  resources :email_processings, only: [:index, :show]

end
