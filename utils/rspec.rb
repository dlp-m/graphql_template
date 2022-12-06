def configure_rspec
  custom_log(__method__)
  remove_dir "test"
  system "rails generate rspec:install"
  create_or_replace_folders(Dir["#{source_paths.first}/spec/*"])
  system "bundle exec rubocop -A"
  system "bundle exec rails db:migrate RAILS_ENV=test"
  system "git add . ; git commit -m 'feat: setup rspec'"
end
