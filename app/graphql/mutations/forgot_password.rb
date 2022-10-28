# frozen_string_literal: true

module Mutations
  class ForgotPassword < BaseMutation
    description 'Forgot Password'

    argument :email, String, required: true

    field :done, Boolean, null: false

    def resolve(email:)
      authorize! User, to: :forgot_password?

      user = User.find_by!(email:)

      user.forgot_password!
      # TODO: send a mail to the user with an URL to the frontend & its confirmation_token
      # UserMailer.reset_password(user).deliver_later

      { done: true }
    end
  end
end
