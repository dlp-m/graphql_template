# frozen_string_literal: true

module Mutations
  class UpdateCurrentUser < BaseMutation
    description 'Update the current user'

    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :password, String, required: false

    field :user, Types::UserType, null: false

    def resolve(**params)
      authorize! current_user, to: :update?, with: UserPolicy

      current_user.update!(params)

      { user: current_user }
    end
  end
end
