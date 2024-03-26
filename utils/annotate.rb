# frozen_string_literal: true

def configure_annotate
  custom_log(__method__)
  system "rails g annotate:install"
  create_or_replace_file('lib/tasks/auto_annotate_models.rake')
  system "git add . ; git commit -m 'feat: setup annotate'"
end
