# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :forgot_password, mutation: Mutations::ForgotPassword
    field :reset_password, mutation: Mutations::ResetPassword
  end
end
