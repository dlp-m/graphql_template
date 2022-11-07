class GqlMutationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_gql_file
    template 'exemple_mutation.rb', File.join('app/graphql/mutations', "#{file_name.underscore}.rb")
    template 'exemple_mutation_spec.rb', File.join('spec/graphql/mutations', "#{file_name.underscore}_spec.rb")
    template 'exemple_mutation.graphql.rb', File.join('spec/fixtures/graphql/mutations/', "#{file_name.underscore}s.graphql")
    update_mutation_type
  end

  private

  def update_mutation_type
    path = 'app/graphql/types/mutation_type.rb'
    mutations = File.read(path).gsub("end\nend\n", "  field :#{file_name.underscore}, mutation: Mutations::#{file_name.camelize}\n  end\nend\n")
    File.write(path, mutations)
  end
end
