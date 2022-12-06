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

  namespace :admin do
    root to:  'admin/users#index'
    resources :users
    resources :administrators
    resources :blog_categories
    resources :blog_posts
    resources :blog_tags
    resources :frequently_asked_questions
  end
end
