def configure_doorkeerper
  custom_log(__method__)
  system "bundle exec rails generate doorkeeper:install"
  system "rails generate doorkeeper:migration"
  system "bundle exec rails db:migrate"
  create_or_replace_file("config/initializers/doorkeeper.rb")
  route(
    " scope :api do
    scope :v1 do
      use_doorkeeper
    end
  end "
)
system "git add . ; git commit -m 'feat: setup doorkeeper'"
end
