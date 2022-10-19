# frozen_string_literal: true

module Tables
  class ActiveRecordThComponent < ViewComponent::Base
    def initialize(column_name:, resource_name: nil)
      @column_name = column_name
      @label = label
      @resource_name = resource_name
      @filters = filters
    end

    def build_order_link(column:, label:)
      return @column_name unless @resource_name

      link_to(
        I18n.t("bo.#{@resource_name}.attributes.#{@column_name}"),
        send("filter_admin_#{@resource_name.pluralize}_path", { column:, direction: next_direction })
      )
    end

    def next_direction
      return unless session[@filters]

      session[@filters]['direction'] == 'asc' ? 'desc' : 'asc'
    end

    def filters
      "#{@resource_name}_filters"
    end

    def sort_indicator
      return @column_name unless @resource_name

      if session[@filters]['direction'] == 'asc'
        '<span>&#8593;</span>'.html_safe
      else
        '<span>&#8595;</span>'.html_safe
      end
    end

    def label
      I18n.t("bo.#{@resource_name}.attributes.#{@column_name}")
    end
  end
end
