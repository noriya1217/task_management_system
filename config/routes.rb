Rails.application.routes.draw do
  constraints ->  request { request.session[:user_id].present? } do
    root to: 'tasks#index'
  end
  root to: 'sessions#new'
  resources :tasks
  resources :users, only:[:new, :create, :show]
  namespace :admin do
    resources :users do
      collection do
        get :error
      end
    end
    resources :labels
  end
  resources :sessions, only:[:new, :create, :destroy]
end
