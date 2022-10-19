# frozen_string_literal: true

module Forms
  class SearchIndexComponent < ViewComponent::Base
    def initialize(resource_name:)
      @resource_name = resource_name
      @path = path
    end

    def path
      "lists_admin_#{@resource_name.pluralize}_path"
    end
  end
end
