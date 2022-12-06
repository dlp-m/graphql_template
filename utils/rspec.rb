def configure_rspec
  custom_log(__method__)
  system "rails generate rspec:install"
  remove_dir "test"
  create_or_replace_folders(Dir["#{source_paths.first}/spec/*"])
  system "bundle exec rubocop -A"
  system "bundle exec rails db:migrate RAILS_ENV=test"
  system "git add . ; git commit -m 'feat: setup rspec'"
end
