# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_current_user, mutation: Mutations::UpdateCurrentUser
    field :forgot_password, mutation: Mutations::ForgotPassword
    field :reset_password, mutation: Mutations::ResetPassword
  end
end
