def configure_bo
  custom_log(__method__)
  add_gems
  system 'bin/setup'
  install_tailwind
  setup_base_files
  change_title
  setup_basics
  generate_blog
  generate_faq
  create_or_replace_folders(Dir["#{source_paths.first}/app/models/*"])
  generate_base_view
  seed
  system "git add . ; git commit -m 'feat: setup bo'"
end

def add_gems
  gem 'acts_as_list'
  gem 'view_component'
  gem 'tailwindcss-rails'
  gem 'simple_form'
  gem 'simple_form-tailwind'
  gem 'ransack'
  gem 'pagy'
  gem_group :development, :test do
    gem 'hotwire-livereload'
  end
end

def install_tailwind
  system 'rails tailwindcss:install'
  ['app/controllers/admin_controller.rb',
   'config/initializers/simple_form_tailwind.rb',
   'config/tailwind.config.js'
  ].each do |file|
    create_or_replace_file(file)
  end
end

def seed
  create_or_replace_folders(Dir["#{source_paths.first}/db/*"])
  system 'bundle exec rails db:seed'
end

def setup_base_files
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
end

def setup_basics
  system "
    n | rails action_text:install;
    ./bin/importmap pin tom-select --download;
    rails g model Administrator confirmation_token:string email:string encrypted_passwor:string first_name:string last_name:string remember_token:string;
    rails db:migrate;
    rails db:migrate RAILS_ENV=test
    "
end

def generate_base_view
  system "
    rails g bo Administrator;
    rails g bo User;
    rails g bo BlogPost;
    rails g bo BlogCategory;
    rails g bo BlogTag;
    rails g bo FrequentlyAskedQuestion;
    "
end

def generate_blog
  run "
    rails g model BlogCategory name:string;
    rails g model BlogPost title:string administrator:references blog_category:references content:rich_text;
    rails g model BlogTag name:string;
    rails g model blog_post_blog_tag blog_tag:references blog_post:references;
    rails db:migrate;
    rails db:migrate RAILS_ENV=test
  "
end

def change_title
  file = "app/views/layouts/admin.html.erb"
  text = File.read(file)
  new_contents = text.gsub(/BaseApi/, "#{@app_const_base.underscore.humanize}")
  File.open(file, "w") {|f| f.puts new_contents }
end

def generate_faq
  run "
    rails g model FrequentlyAskedQuestion title:string position:integer content:rich_text;
    rails db:migrate;
    rails db:migrate RAILS_ENV=test
    "
end
