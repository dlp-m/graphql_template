def chore
  custom_log(__method__)
  system "echo coverage/**/* >> .gitignore"
  system "git add . ; git commit -m 'chore: update gitignore'"
  system "bundle exec rubocop -A"
  system "bundle exec rspec"
  system "git add . ; git commit -m 'feat: rubocop'"
end
