# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  skip_pre_check :authenticated?, only: %i[forgot_password? reset_password?]

  def show?
    user == record
  end

  def update?
    user == record
  end

  def forgot_password?
    true
  end

  def reset_password?
    true
  end

  # relation_scope do |scope|
  #   scope.all
  # end
end
