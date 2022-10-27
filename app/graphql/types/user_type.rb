# frozen_string_literal: true

module Types
  class UserType < Types::BaseType
    description 'A user'

    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
  end
end
