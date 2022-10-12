class GqlMutationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_gql_file
    template 'exemple_mutation.rb', File.join('app/graphql/mutations', "#{file_name.underscore}.rb")
    template 'exemple_mutation_spec.rb', File.join('spec/graphql/mutations', "#{file_name.underscore}s_spec.rb")
    template 'exemple_mutation.graphql.rb', File.join('spec/fixtures/graphql/mutations/', "#{file_name.underscore}s.graphql")
  end
end
