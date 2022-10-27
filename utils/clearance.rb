def configure_clearance
  custom_log(__method__)
  system 'rails generate clearance:install'
  create_or_replace_file('app/controllers/application_controller.rb')
  system 'rails g migration add_first_name_and_last_name_to_users first_name:string last_name:string'
  system 'bundle exec rails db:migrate'
  system "git add . ; git commit -m 'feat: setup clearance'"
end
