Rails.application.routes.draw do
  # namespace :admin do
  #     resources :comments
  #     resources :posts
  #     resources :roles
  #     resources :users
  #
  #     root to: "comments#index"
  #   end

  namespace :admin do
    resources :users
    resources :roles, only: [:index, :show]
    root to: "users#index"
  end

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :posts do
    resources :comments
  end

  root 'pages#home'

  resources :pages do
    collection do
      get 'home'
      get 'find'
      get 'privacy'
    end
  end

end
