Rails.application.routes.draw do
  resources :surveys, only: [:index, :show] do
    resources :responses, only: [:create]
    get 'kpi_dashboard', to: 'kpis#dashboard'
  end
  
  root 'surveys#index'
end