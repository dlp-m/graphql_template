def configure_rspec
  custom_log(__method__)
  system "rails generate rspec:install"
  remove_dir "test"
  system "rails generate rspec:install"
  %w[
    spec/spec_helper.rb
    spec/rails_helper.rb
    spec/helpers/graphql.rb
    spec/helpers/authentication_contexts.rb
    spec/acceptance_helper.rb
    spec/fabricators/doorkeeper_application_fabricator.rb
    spec/fabricators/doorkeeper_token_fabricator.rb
    spec/fabricators/user_fabricator.rb
    spec/acceptance/authentication_spec.rb
    spec/graphql/queries/current_user_spec.rb
    spec/fixtures/graphql/users.graphql
  ].each do |file|
    create_or_replace_file(file)
  end
  system "bundle exec rubocop -A"
  system "git add . ; git commit -m 'feat: setup rspec'"
end
