Rails.application.routes.draw do
  devise_for :users

  resources :ideas do
  resources :comments, only: [:create, :destroy], shallow: true
  end
  
  resources :tags
  resources :comments, only: []

  authenticated :user do
    root to: 'ideas#index', as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
