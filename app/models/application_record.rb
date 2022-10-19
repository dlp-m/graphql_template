# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include FilterableConcern

  primary_abstract_class
end
