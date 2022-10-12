query <%= class_name.camelize(:lower) %>s{
  <%= class_name.camelize(:lower) %>s{
    nodes{
      <%- class_name.constantize.columns.each do |column| -%>
      <%- next if class_name.constantize.reflect_on_all_associations.map(&:foreign_key).include?(column.name) -%>
        <%= column.name.camelize(:lower)%>
      <%- end -%>
    }
  }
}
