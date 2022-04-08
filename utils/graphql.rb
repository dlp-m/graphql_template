def configure_graphql
  custom_log(__method__)
  system "rails generate graphql:install"
  gem 'graphql_playground-rails'
  gem 'graphql-rails_logger'
  system "bundle install"
  route "mount GraphqlPlayground::Rails::Engine, at: '/graphql_playground', graphql_path: '/graphql' if Rails.env.development? "
  remove_file "app/graphql/types/node_type.rb"
  %w[
    app/controllers/api_controller.rb
    app/controllers/graphql_controller.rb
    app/graphql/types/query_type.rb
    app/graphql/types/user_type.rb
    config/initializers/graphql_rails_logger.rb
    app/graphql/resolvers/base_resolver.rb
    app/policies/application_policy.rb
    app/policies/user_policy.rb
    app/graphql/mutations/base_mutation.rb
    app/graphql/types/base_object.rb
    app/graphql/types/base_type.rb
    app/graphql/current_user_context.rb
    app/graphql/types/base_connection.rb
  ].each do |file|
    create_or_replace_file(file)
  end
  file = "app/graphql/#{@app_name}_schema.rb"
  remove_file file
  copy_file "app/graphql/project_name_schema.rb", file
  text = File.read(file)
  new_contents = text.gsub(/ProjectApi/, "#{@app_const_base}")
  File.open(file, "w") {|f| f.puts new_contents }
  system "bundle exec rails db:drop db:create db:migrate"
  system "git add . ; git commit -m 'feat: configure graphql'"
end
