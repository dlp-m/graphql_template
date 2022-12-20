# frozen_string_literal: true

class AdminController < ApplicationController
  include Pagy::Backend
  layout 'admin'
  before_action :authenticate_administrator!
end
