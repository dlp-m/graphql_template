class BoNamespaceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)
  
  def create_bo_namespace_files
    run "bundle exec rails g devise #{file_name.capitalize}"
    run 'bundle exec rails db:migrate'
    create_routes_and_views
    template 'admin.html.erb', File.join('app/views/layouts/', "#{singular_name}.html.erb")
    template 'admin_controller.rb', File.join('app/controllers/', "#{singular_name}_controller.rb")
    template 'seeds.rb', File.join('db/seeds/', "#{plural_name}.rb")
    template 'side_bar.html.erb', File.join('app/views/', "#{plural_name}/layouts/_side_bar.html.erb")
    create_directories
    add_seed_file
  end

  def create_directories
    ["app/views/#{plural_name}", "app/controllers/#{plural_name}"].each do |dir|
      FileUtils.mkdir(dir) unless File.directory?(dir)
    end
  end
  
  def add_seed_file
    inject_into_file 'db/seeds.rb' do 
      "require_relative 'seeds/#{plural_name}.rb'\n"
    end
  end

  private

  def plural_name
    singular_name.pluralize
  end

  def singular_name
    file_name.underscore
  end

  def create_routes_and_views
    run "rails g bo #{singular_name.camelize} --namespace #{plural_name}"
    devise_route = "  devise_for :#{singular_name},
                path: '#{plural_name}',
                controllers: {
                  sessions: 'custom_devise/sessions',
                  passwords: 'custom_devise/passwords'
                }\n"
    gsub_file('config/routes.rb', /devise_for :#{plural_name}/, '')
    route devise_route
    route "namespace :#{plural_name} do
            root to:  '#{plural_name}#index'
            resources :#{plural_name}
           end"
  end
end

