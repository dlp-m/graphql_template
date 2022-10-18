def configure_bo
  custom_log(__method__)
  gem 'view_component'
  gem 'tailwindcss-rails'
  gem 'simple_form'
  gem 'simple_form-tailwind'
  gem 'pagy'
  gem_group :development, :test do
    gem 'hotwire-livereload'
  end
  system 'bin/setup'
  system 'rails tailwindcss:install'
  ['app/controllers/admin_controller.rb',
   'config/initializers/simple_form_tailwind.rb',
   'config/tailwind.config.js'
  ].each do |file|
    create_or_replace_file(file)
  end
  [
    'app/helpers/*',
    'app/javascript/*',
    'app/views/*',
    'app/components/*',
    'lib/generators/*',
    'app/assets/stylesheets/*'
  ].each do |folder|
    create_or_replace_folders(Dir["#{source_paths.first}/#{folder}"])
  end
 
  file = "app/views/layouts/admin.html.erb"
  text = File.read(file)
  new_contents = text.gsub(/RifApi/, "#{@app_const_base.underscore.humanize}")
  File.open(file, "w") {|f| f.puts new_contents }
end
