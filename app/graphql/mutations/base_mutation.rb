# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    include Mutations::Resolvers::Validation
    include ActionPolicy::GraphQL::Behaviour
    include CurrentUserContext
  end
end