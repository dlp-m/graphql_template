# frozen_string_literal: true
def configure_graphql
  custom_log(__method__)
  system "rails generate graphql:install"
  gem 'graphql_playground-rails'
  gem 'graphql-rails_logger'
  gem 'dry-effects'
  gem 'ralphql_generator'
  system "bundle install"
  remove_file "app/graphql/types/node_type.rb"
  create_or_replace_folders(files: Dir["#{source_paths.first}/app/graphql/*"])
  %w[
    app/controllers/api_controller.rb
    app/controllers/graphql_controller.rb
    config/initializers/graphql_rails_logger.rb
    app/policies/application_policy.rb
    app/policies/user_policy.rb
  ].each do |file|
    create_or_replace_file(file)
  end
  file = "app/graphql/#{@app_name}_schema.rb"
  remove_file file
  copy_file "app/graphql/project_name_schema.rb", file
  text = File.read('app/graphql/project_name_schema.rb')
  new_contents = text.gsub(/ProjectApi/, "#{@app_const_base}")
  File.open(file, "w") {|f| f.puts new_contents }
  remove_file 'app/graphql/project_name_schema.rb'
  inject_into_file "app/models/application_record.rb", after: "  primary_abstract_class\n" do
    "  def to_guid\n    #{@app_const_base}ApiSchema.id_from_object(self, nil, nil)\n  end\n"
  end
  system "bundle exec rails db:drop db:create db:migrate"
  create_or_replace_file('config/routes.rb')
  system "git add . ; git commit -m 'feat: configure graphql'"
end
