module Filterable
  def filter!(resource)
    store_filters(resource)
    apply_filters(resource)
  end

  def lists
    object = self.class.to_s.delete_prefix('Admin::').delete_suffix('Controller')
    resource = instance_variable_set("@#{object.underscore}", filter!(object.singularize.constantize))
    @pagy = pagy(resource).first
    render('index')
  end

  private

  def store_filters(resource)
    session["#{resource.to_s.underscore}_filters"] = {} unless session.key?("#{resource.to_s.underscore}_filters")
    session["#{resource.to_s.underscore}_filters"].merge!(filter_params_for(resource))
  end

  def filter_params_for(resource)
    params.permit(resource::FILTER_PARAMS)
  end

  def apply_filters(resource)
    resource.filter(session["#{resource.to_s.underscore}_filters"])
  end
end
