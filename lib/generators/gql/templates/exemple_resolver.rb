# frozen_string_literal: true

module Resolvers
  class <%= class_name %>Resolver < BaseResolver
    include SearchObject.module(:graphql)

    description 'Search resolver for <%= class_name.underscore %>'

    type Types::<%= class_name %>Type.connection_type, null: false

    scope do
      authorized_scope(<%= class_name %>.all)
    end

    class OrderColumnEnum < Types::BaseEnum
      description 'Available columns for ordering'

      graphql_name '<%= class_name %>OrderColumn'
      value 'CREATED_AT', value: :created_at
      value 'UPDATED_AT', value: :updated_at
    end

    class <%= class_name %>OrderCriteria < Types::BaseInputObject
      description 'Criteria for ordering'

      argument :column, OrderColumnEnum, required: true
      argument :direction, Types::OrderDirectionType, required: true
    end

    DEFAULT_ORDER = { column: :created_at, direction: :asc }.freeze

    option(
      :order,
      type: <%= class_name %>OrderCriteria, default: DEFAULT_ORDER
    ) do |scope, order|
      scope.order(order.column => order.direction)
    end
  end
end
