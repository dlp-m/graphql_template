def configure_clearance
  custom_log(__method__)
  system "rails generate clearance:install"
  create_or_replace_file('app/controllers/application_controller.rb')
  system "bundle exec rails db:migrate"
  system "git add . ; git commit -m 'feat: setup clearance'"
end
