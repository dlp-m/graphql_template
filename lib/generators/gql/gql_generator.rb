# frozen_string_literal: true

class GqlGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_gql_file
    template 'exemple_policy.rb', File.join('app/policies/', "#{file_name.underscore}_policy.rb")
    template 'exemple_spec.rb', File.join('spec/graphql/queries', "#{file_name.underscore}s_spec.rb")
    template 'exemple_resolver.rb', File.join('app/graphql/resolvers', "#{file_name.underscore}_resolver.rb")
    template 'exemple.graphql.rb', File.join('spec/fixtures/graphql', "#{file_name.underscore}s.graphql")
    template 'exemple_type.rb', File.join('app/graphql/types', "#{file_name.underscore}_type.rb")
  end

  private # Example method that can be invoked from the template

  def excluded_columns
    %i[id created_at updated_at]
  end

  def graphqlTypeFor(type)
    types = {
      string: 'String',
      text: 'String',
      integer: 'Int',
      float: 'Float',
      boolean: 'Boolean',
      datetime: 'ISO8601DateTime',
      date: 'ISO8601Date',
      json: 'JSON'
    }
    types[type]
  end
end
