# frozen_string_literal: true

class GqlGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_gql_file
    template 'exemple_policy.rb', File.join('app/policies/', "#{file_name.underscore}_policy.rb")
    template 'exemple_spec.rb', File.join('spec/graphql/queries', "#{file_name.underscore.pluralize}_spec.rb")
    template 'exemple_resolver.rb', File.join('app/graphql/resolvers', "#{file_name.underscore}_resolver.rb")
    template 'exemple.graphql.rb', File.join('spec/fixtures/graphql', "#{file_name.underscore.pluralize}.graphql")
    template 'exemple_type.rb', File.join('app/graphql/types', "#{file_name.underscore}_type.rb")
    insert_into_query_type
  end

  private # Example method that can be invoked from the template

  def excluded_columns
    %i[id created_at updated_at]
  end

  def base_order_columns
    %i[created_at updated_at position]
  end

  def insert_into_query_type
    inject_into_file 'app/graphql/types/query_type.rb', after: "# Index Queries\n" do 
    "    field :#{file_name.underscore.pluralize},
          Types:: #{class_name.constantize}Type.connection_type,
          resolver: Resolvers::#{class_name.constantize}Resolver,
          preauthorize: { to: :index?, with: #{class_name.constantize}Policy },
          connection: GraphQL::Connections::Stable,
          null: false\n"
    end
  end

  def graphqlTypeFor(type)
    types = {
      string: 'String',
      text: 'String',
      integer: 'Int',
      float: 'Float',
      boolean: 'Boolean',
      datetime: 'GraphQL::Types::ISO8601DateTime',
      date: 'GraphQL::Types::ISO8601Date',
      json: 'JSON'
    }
    types[type]
  end
end
