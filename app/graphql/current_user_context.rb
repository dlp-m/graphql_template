# frozen_string_literal: true

module CurrentUserContext
  include Doorkeeper::Rails::Helpers

  def doorkeeper_token
    context[:doorkeeper_token]
  end

  def current_user
    return context[:current_user] if context[:current_user].present?
    return unless doorkeeper_token&.resource_owner_id&.present?
    doorkeeper_authorize! if doorkeeper_token

    @current_user = User.find(doorkeeper_token.resource_owner_id)
    context[:current_user] = @current_user
  end
end
