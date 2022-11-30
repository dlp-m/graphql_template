# frozen_string_literal: true

class BoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  load "#{Rails.root}/lib/generators/bo/utils/translations.rb"
  check_class_collision suffix: 'bo'

  def create_bo_file
    # Template method
    # First argument is the name of the template
    # Second argument is where to create the resulting file. In this case, app/bo/my_bo.rb
    template 'new.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/new.html.erb")
    template 'item.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_#{file_name.underscore}.html.erb")
    template '_form.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_form.html.erb")
    template 'index.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/index.html.erb")
    template '_table.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_table.html.erb")
    template '_search_bar.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/_search_bar.html.erb")
    template 'show.html.erb', File.join('app/views/admin', "#{file_name.pluralize}/show.html.erb")
    template 'controller.rb', File.join('app/controllers/admin', "#{file_name.pluralize}_controller.rb")
    create_translations
  end

  def bo_model
    class_name.constantize
  end

  def model_columns
    bo_model.column_names.map(&:to_sym)
  end

  def bo_model_title(model=nil)
    return unless model
    columns = model.column_names.map(&:to_sym)
    %i[title name email id].each do |col|
      return col if columns.include? col
    end
  end

  def excluded_columns
    %i[id created_at updated_at]
  end

  def permited_params
    params = {}
    action_text_columns= has_one_assoc&.select {|a| a.name == :rich_text_content}
    model_columns&.map do |col|
      params["#{col}".to_sym] = nil
    end
    action_text_columns&.map do |col|
      params["#{col.name.to_s.remove('rich_text_' )}".to_sym] = nil
    end
    has_many_assoc&.map do |association|
       params["#{association.class_name.underscore}_ids".to_sym] = []
    end
    params
  end

  def has_many_assoc
    bo_model.reflect_on_all_associations(:has_many)
  end

  def belongs_to_assoc
    bo_model.reflect_on_all_associations(:belongs_to)
  end

  def has_one_assoc
    bo_model.reflect_on_all_associations(:has_one)
  end

  def permited_columns
    model_columns - excluded_columns
  end
end
