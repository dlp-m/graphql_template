# frozen_string_literal: true

class <%= class_name %>Policy < ApplicationPolicy
  relation_scope(&:all)
end
