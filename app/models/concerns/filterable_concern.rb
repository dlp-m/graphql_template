# frozen_string_literal: true

require 'active_support/concern'

module FilterableConcern
  extend ActiveSupport::Concern
  FILTER_PARAMS = %i[search column direction].freeze

  included do
    def self.filter(filters)
      if respond_to?(:filterable)
        filterable(filters['search']).order("#{filters['column']} #{filters['direction']}")
      else
        order("#{filters['column']} #{filters['direction']}")
      end
    end
  end
end
