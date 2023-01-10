def configure_bo
  custom_log(__method__)
  add_gems
  run 'bin/setup'
  install_tailwind
  setup_base_files
  setup_basics
  setup_devise
  run 'rails g bo User'
  generate_blog if yes?("Generate blog ?")
  generate_faq if yes?("Generate F.A.Q ?")
  run 'bundle exec rails db:seed'
  run "git add . ; git commit -m 'feat: setup bo'"
end

def setup_devise
  run 'bundle exec rails g devise:install'
  run 'bundle exec rails db:migrate'
   %w[
    config/initializers/devise.rb
    app/controllers/custom_devise/confirmations_controller.rb
    app/controllers/custom_devise/omniauth_callbacks_controller.rb
    app/controllers/custom_devise/passwords_controller.rb
    app/controllers/custom_devise/registrations_controller.rb
    app/controllers/custom_devise/sessions_controller.rb
    app/controllers/custom_devise/unlocks_controller.rb
  ].each do |file|
    create_or_replace_file(file)
  end
  run 'rails g bo_namespace Administrator'
  run 'bundle exec rails db:migrate'
  create_or_replace_folders(['app/views/devise'])
  run 'bundle exec rails db:migrate'
end

def add_gems
  gem 'acts_as_list'
  gem 'view_component'
  gem 'tailwindcss-rails'
  gem 'simple_form'
  gem 'simple_form-tailwind'
  gem 'ransack'
  gem 'pagy'
  gem 'devise'
  gem_group :development, :test do
    gem 'hotwire-livereload'
  end
end

def install_tailwind
  system 'rails tailwindcss:install'
  [
   'config/initializers/simple_form_tailwind.rb',
   'config/tailwind.config.js'
  ].each do |file|
    create_or_replace_file(file)
  end
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
  run "n | rails action_text:install"
  run "./bin/importmap pin tom-select --download"
  run 'rails db:migrate; rails db:migrate RAILS_ENV=test'
  %w[
    db/seeds.rb
    db/seeds/users.rb
  ].each do |file|
    create_or_replace_file(file)
  end
end

def generate_blog
  run 'rails g model BlogCategory name:string'
  run 'rails g model BlogPost title:string administrator:references blog_category:references content:rich_text'
  run 'rails g model BlogTag name:string'
  run 'rails g model blog_post_blog_tag blog_tag:references blog_post:references'
  run 'rails db:migrate; rails db:migrate RAILS_ENV=test;'
  %w[ 
  app/models/blog_category.rb
  app/models/blog_post_blog_tag.rb
  app/models/blog_post.rb
  app/models/blog_tag.rb
  db/seeds/blogs.rb
  ].each do |file|
    create_or_replace_file(file)
  end
  append_to_file 'db/seeds.rb' do <<-'RUBY'
     require_relative 'seeds/blogs' 
    RUBY
  end
  run 'rails g bo BlogPost'
  run 'rails g bo BlogCategory'
  run 'rails g bo BlogTag'
end

def generate_faq
  run 'rails g model FrequentlyAskedQuestion title:string position:integer content:rich_text'
  run 'rails db:migrate; rails db:migrate RAILS_ENV=test'
  create_or_replace_file('db/seeds/frequently_asked_questions.rb')
  create_or_replace_file('app/models/frequently_asked_question.rb')
  append_to_file 'db/seeds.rb' do  <<-'RUBY'
     require_relative 'seeds/frequently_asked_questions.rb' 
    RUBY
  end
  run 'rails g bo FrequentlyAskedQuestion'
  run 'rails g gql FrequentlyAskedQuestion'
  create_or_replace_file('spec/fabricators/frequently_asked_question_fabricator.rb')
  create_or_replace_file('spec/graphql/queries/frequently_asked_questions_spec.rb')
  create_or_replace_file('app/policies/frequently_asked_question_policy.rb')
end
