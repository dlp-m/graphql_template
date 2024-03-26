# frozen_string_literal: true

def configure_doorkeerper
  custom_log(__method__)
  system "echo n | bundle exec rails generate doorkeeper:install"
  system "rails generate doorkeeper:migration"
  system "bundle exec rails db:migrate"
  system "git add . ; git commit -m 'feat: setup doorkeeper'"
end
