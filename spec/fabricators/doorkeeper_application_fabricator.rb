# frozen_string_literal: true

Fabricator(:application, class_name: 'Doorkeeper::Application') do
  name { 'user' }
  scopes { 'user' }
  uid { SecureRandom.uuid }
  secret { SecureRandom.uuid }
  confidential { false }
  redirect_uri { Faker::Internet.url(scheme: 'https') }
end
