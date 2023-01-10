# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  # Devise routing overwrite for multiples resources
  def after_sign_in_path_for(resource)
    send("#{resource.class.name.underscore.pluralize}_root_path")
  end

  def after_sign_out_path_for(resource)
    send("new_#{resource}_session_path")
  end
end
