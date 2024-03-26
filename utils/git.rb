# frozen_string_literal: true

def configure_git
  custom_log(__method__)
  system "git init; git add . ; git commit -m 'feat: first commit'"
  system "bundle install"
end
