def configure_bo
  custom_log(__method__)
  gem 'view_component'
  gem 'tailwindcss-rails', '~> 2.0'
  gem 'simple_form', '~> 5.1.0'
  gem 'simple_form-tailwind'
  gem_group :development, :test do
    gem 'hotwire-livereload'
  end
  system 'bin/setup'
  system 'rails tailwindcss:install'
  ['app/controllers/admin_controller.rb',
   'app/helpers/flash_helper.rb',
   'config/initializers/simple_form_tailwind.rb',
   'app/assets/stylesheets/application.tailwind.css',
   'config/tailwind.config.js'
  ].each do |file|
    create_or_replace_file(file)
  end
  create_or_replace_folders(Dir["#{source_paths.first}/app/views/*"])
  create_or_replace_folders(Dir["#{source_paths.first}/app/components/*"])
  create_or_replace_folders(Dir["#{source_paths.first}/lib/generators/*"])
end

def create_or_replace_folders(files)
  files.each do |file|
    if File.directory?(file)
      create_or_replace_folders(Dir["#{file}/*"])
    else
      file.slice!("#{source_paths.first}/")
      create_or_replace_file(file)
    end
  end
end
