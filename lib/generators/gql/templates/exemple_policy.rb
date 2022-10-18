# frozen_string_literal: true

class <%= class_name %>Policy < ApplicationPolicy
  relation_scope do |scope|
    raise "Add custom policy scope in #{__FILE__}"
  end
end
