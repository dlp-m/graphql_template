# frozen_string_literal: true

class AdminController < ApplicationController
  include Pagy::Backend
  layout 'admin'
  # include Clearance::Controller
  before_action :require_login
  before_action :current_user

  private

  def require_login
    # todo add custom admin login
    deny_access(I18n.t('flashes.failure_when_not_signed_in')) unless true
  end

  def current_user
    @current_user =OpenStruct.new(email: 'michel@tymaye.com')
  end
end
