# frozen_string_literal: true

class BoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  check_class_collision suffix: 'bo'

  def create_bo_file
    # Template method
    # First argument is the name of the template
    # Second argument is where to create the resulting file. In this case, app/bo/my_bo.rb
    template 'new.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/new.html.erb")
    template 'item.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_#{file_name.downcase}.html.erb")
    template 'index.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/index.html.erb")
    template '_table.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_table.html.erb")
    template 'show.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/show.html.erb")
    template 'controller.rb', File.join('app/controllers/admin', "#{file_name.pluralize}_controller.rb")
  end

  private 

  def excluded_columns
    %i[id created_at updated_at]
  end
end
