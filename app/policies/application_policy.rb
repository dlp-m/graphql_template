class ApplicationPolicy < ActionPolicy::Base
  include Doorkeeper::Rails::Helpers

  authorize :doorkeeper_token, allow_nil: true
  authorize :user, optional: true

  pre_check :authenticated?

  def authenticated?
    doorkeeper_authorize!(:app)
  end

  def index?
    true
  end
end
