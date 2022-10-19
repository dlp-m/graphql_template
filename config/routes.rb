# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  mount GraphqlPlayground::Rails::Engine, at: '/graphql_playground', graphql_path: '/graphql' if Rails.env.development?
  scope :api do
    scope :v1 do
      use_doorkeeper
    end
  end
  # bo
  root to: 'admin/users#index'
  concern :filterable do
    collection do
      get :filter
    end
  end
  namespace :admin do
    root to:  'admin/users#index'
    resources :users, concerns: [:filterable]
  end
end
