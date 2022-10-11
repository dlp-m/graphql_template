# frozen_string_literal: true

module Types
  class <%= class_name %>Type < Types::BaseType
    description 'A <%= class_name %>'
    <% class_name.constantize.columns.each do |column| %>
      <% next if excluded_columns.include?(column.name.to_sym) %>
      field :<%= column.name %>, <%= graphqlTypeFor(column.type) %>, null: <%= column.null %>
    <% end %>
  end
end
