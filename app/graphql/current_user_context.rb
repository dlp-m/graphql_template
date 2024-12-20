# frozen_string_literal: true

module CurrentUserContext
  include Doorkeeper::Rails::Helpers

  def doorkeeper_token
    context[:doorkeeper_token]
  end

  def current_user
    return context[:current_user] if context[:current_user].present?

    return nil if doorkeeper_token.nil?

    doorkeeper_authorize!(:user)

    @current_user = User.find(doorkeeper_token.resource_owner_id)
    context[:current_user] = @current_user
  end
end
