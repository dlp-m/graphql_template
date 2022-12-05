def chore
  custom_log(__method__)
  system "touch .env; touch .env.exemple"
  system "echo .env >> .gitignore"
  system "echo coverage/**/* >> .gitignore"
  system "git add . ; git commit -m 'chore: update gitigore'"
  after_bundle do
    system "bin/setup"
    system "git add . ; git commit -m 'chore: run rails setup'"
    configure_bo
    system "bundle exec rubocop -A"
    system "bundle exec rspec"
    system "git add . ; git commit -m 'feat: rubocop'"
  end
end
