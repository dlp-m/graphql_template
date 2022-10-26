# frozen_string_literal: true

module Mutations
  class ResetPassword < BaseMutation
    description 'Reset password'

    argument :reset_token, String, required: true
    argument :password, String, required: true

    field :password_reset, Boolean, null: false

    def resolve(reset_token:, password:)
      authorize! User, to: :reset_password?

      user = User.find_by!(confirmation_token: reset_token)

      { password_reset: user.update_password(password) }
    end
  end
end
