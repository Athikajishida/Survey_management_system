Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout', # this creates logout_path
    registration: 'signup'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'  # <- THIS defines logout_path
    get 'signup', to: 'devise/registrations#new'
  end

  authenticated :user do
    root to: 'surveys#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end
  resources :responses, only: [:create]

  root to: redirect('/')

  get 'dashboard', to: 'surveys#index'
    resources :surveys, only: [:index, :show] do
    resources :responses, only: [:create]
  end
  resources :users, only: [] do
    get 'dashboard', to: 'kpis#user_dashboard', as: :dashboard
  end
  resources :surveys do
    get 'dashboard', to: 'kpis#dashboard', as: :dashboard
  end
  namespace :admin do
    get "dashboard/index"
    root to: 'dashboard#index'
  
    resources :surveys
    resources :categories
    resources :questions
    resources :tags
  end
end
