require_relative 'utils/methods.rb'
require_relative 'utils/git.rb'
require_relative 'utils/gemfile.rb'
require_relative 'utils/graphql.rb'
require_relative 'utils/annotate.rb'
require_relative 'utils/rubocop.rb'
require_relative 'utils/doorkeeper.rb'
require_relative 'utils/clearance.rb'
require_relative 'utils/rspec.rb'
require_relative 'utils/chore.rb'
def source_paths
  [__dir__]
end
# we need to add doorkeeper first because it raise an errors
create_or_replace_file("config/initializers/doorkeeper.rb")
configure_git
configure_gemfile
configure_doorkeerper
configure_graphql
configure_annotate
configure_rubocop
configure_clearance
configure_rspec
chore
