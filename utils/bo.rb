# frozen_string_literal: true

def configure_bo
  custom_log(__method__)
  add_gems
  run 'bin/setup'
  setup_basics
  setup_mailer
  run 'rails g bo User'
  generate_blog if yes?("Generate blog ?")
  generate_faq if yes?("Generate F.A.Q ?")
  run 'bundle exec rails db:seed'
  run "git add . ; git commit -m 'feat: setup bo'"
end

def add_gems
  gem 'acts_as_list'
  gem 'tybo', '~> 0.0.32'
  gem 'devise', '~> 4.8', '>= 4.8.1'
  run 'bundle install'
  run 'rails g tybo_install'
  run 'bundle exec rails db:seed'
  gem_group :development, :test do
    gem 'hotwire-livereload'
  end
end

def setup_mailer
  gem 'mailersend-ruby'
  ['.env', '.env.exemple'].each { |file |create_or_replace_file(file) } 
  system "echo .env >> .gitignore"
  inject_into_file 'config/environments/development.rb', after: "config.action_mailer.perform_caching = false\n" do 
    <<-'RUBY'
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    RUBY
  end
  create_or_replace_folders(files: Dir["#{source_paths.first}/app/mailers/*"])
end

def setup_basics
  run "n | rails action_text:install"
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
  update_faq_resolver
  create_or_replace_file('spec/fabricators/frequently_asked_question_fabricator.rb')
  create_or_replace_file('spec/graphql/queries/frequently_asked_questions_spec.rb')
  create_or_replace_file('app/policies/frequently_asked_question_policy.rb')
end

def update_faq_resolver
  inject_into_file 'app/graphql/resolvers/frequently_asked_question_resolver.rb', after: "DEFAULT_ORDER = { column: :created_at, direction: :asc }.freeze\n\n" do 
    <<-'RUBY'
    option(
        :search,
        type: String, description: 'Case insensitive partial matching by title or content'
      ) do |scope, value|
      scope.joins(:action_text_rich_text).where('title ILIKE ?', "%#{value}%").or(
        scope.where('action_text_rich_texts.body ILIKE ?', "%#{value}%")
      )
    end

    RUBY
  end
end
