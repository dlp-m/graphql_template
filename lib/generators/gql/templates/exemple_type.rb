# frozen_string_literal: true

module Types
  class <%= class_name %>Type < Types::BaseType
    description 'A <%= class_name %>'

    <%- class_name.constantize.columns.each do |column| -%>
    <%- next if excluded_columns.include?(column.name.to_sym) || class_name.constantize.reflect_on_all_associations.map(&:foreign_key).include?(column.name) -%>
    field :<%= column.name %>, <%= graphqlTypeFor(column.type) %>, null: <%= column.null %>
    <%- end -%>
    # belongs_to Associations
    <%- class_name.constantize.reflect_on_all_associations(:belongs_to).each do |association| -%>
    field :<%= association.name %>, Types::<%= association.klass.name %>Type, null: false
    <%- end -%>
    # has_many Associations
    <%- class_name.constantize.reflect_on_all_associations(:has_many).each do |association| -%>
    field :<%= association.name %>, Types::<%= association.klass.name %>Type.connection_type, resolver: Resolvers::<%= association.klass.name %>Resolver, null: true
    <%- end -%>
    # has_one Associations
    <%- class_name.constantize.reflect_on_all_associations(:has_one).each do |association| -%>
    <%- if association.options[:class_name] == "ActionText::RichText" -%>
    field :<%= association.name %>, String, null: true
    <%- else -%>
    field :<%= association.name %>, Types::<%= association.klass.name %>Type, null: true
    <%- end -%>
    <%- end -%>
  end
end

