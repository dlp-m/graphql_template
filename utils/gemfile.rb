# frozen_string_literal: true

def configure_gemfile
  custom_log(__method__)
  gem "graphql"
  gem 'clearance'
  gem 'doorkeeper'
  gem "graphql-extras"
  gem 'graphql-connections'
  gem 'search_object_graphql'
  gem 'action_policy'
  gem 'action_policy-graphql'
  gem 'globalid'
  gem 'rspec_api_documentation'
  gem 'activerecord_where_assoc'

  gem_group :development, :test do
    gem "colorize_logs"
    # Shim to load environment variables from .env into ENV in development.
    gem 'dotenv-rails'
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platforms: %i[mri mingw x64_mingw]
    # Behaviour Driven Development for Ruby
    gem 'rspec'
    # rspec-rails is a testing framework for Rails 5+.
    gem 'rspec-rails'
    # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
    gem 'simplecov'
    # Fabrication is an object generation framework for ActiveRecord or any other Ruby object.
    gem 'fabrication'
    # A library for generating fake data such as names, addresses, and phone numbers.
    gem 'faker'
    # Use Pry as your rails console
    gem 'pry-rails'
  end
  gem_group :development do
    # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis.
    gem 'brakeman'
    # bundler-audit provides patch-level verification for Bundled apps.
    gem 'bundler-audit'
    # A Ruby static code analyzer and formatter, based on the community Ruby style guide.
    gem 'rubocop'
    # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
    gem 'rubocop-rails'
    # A collection of RuboCop cops to check for performance optimizations in Ruby code.
    gem 'rubocop-performance'
    # A plugin for the RuboCop code style enforcing & linting tool for RSpec files.
    gem 'rubocop-rspec'
    # A collection of RuboCop cops to improve GraphQL-related code
    gem 'rubocop-graphql'
    # Add a comment summarizing the current schema to the top or bottom of each of your...
    gem 'annotate'
  end
  run "bundle install"
end
