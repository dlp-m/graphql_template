# frozen_string_literal: true

def configure_rubocop
  custom_log(__method__)
  create_or_replace_file('.rubocop.yml')
  system "bundle exec rubocop -A"
  system "bundle exec rubocop --auto-gen-config"
  system "git add . ; git commit -m 'feat: setup rubocop'"
end
