# frozen_string_literal: true

Rails.application.routes.draw do
  # Root
  root to: 'custom_devise/login#home'
  # Graphql
  post '/graphql', to: 'graphql#execute'
  mount GraphqlPlayground::Rails::Engine, at: '/graphql_playground', graphql_path: '/graphql' if Rails.env.development?
  scope :api do
    scope :v1 do
      use_doorkeeper
    end
  end
end
