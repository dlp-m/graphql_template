# frozen_string_literal: true

def configure_tools
  custom_log(__method__)
  create_or_replace_folders(files: Dir["#{source_paths.first}/scripts/*"])
  Dir['scripts/*'].each do |file|
    gsub_file(file, /project-api/, @app_const_base.underscore.gsub("_", "-"))
  end
  create_or_replace_folders(files: Dir["#{source_paths.first}/lib/templates/*"])
  run 'git add . ; git commit -m "feat: add model template and scalingo utils"'
end
