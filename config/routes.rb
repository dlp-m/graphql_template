Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  mount GraphqlPlayground::Rails::Engine, at: '/graphql_playground', graphql_path: '/graphql' if Rails.env.development?
  scope :api do
     scope :v1 do
       use_doorkeeper
     end
   end
  # bo
  namespace :admin do
    root to: "thematics#index"
    resources :users
    resources  :administrators
    resources  :thematics
    resources  :questions
    resources  :choices
    resources  :answers
    resources  :categories
    resources  :devices
    resources  :feeds
    resources  :frequently_asked_questions
    resources  :swipe_cards
    resources  :swipe_cards_users
    resources  :terms
    resources  :testimonials
    resources  :thematic_users
  end
end
