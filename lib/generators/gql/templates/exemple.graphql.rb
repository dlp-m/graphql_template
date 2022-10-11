query <%= class_name.downcase %>s{
  <%= class_name.downcase %>s{
    nodes{
      <% class_name.constantize.columns.each do |column| %>
        <%= column.name.camelize(:lower)%>
      <% end %>
    }
  }
}
