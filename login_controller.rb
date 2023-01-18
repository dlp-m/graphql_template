# frozen_string_literal: true
module CustomDevise
  class LoginController < ApplicationController
    layout 'devise_admin'
    def home
      @resources = Devise.mappings.sort.map(&:first)
      render template: "devise/login/home"
    end
  end
end
