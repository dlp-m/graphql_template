module Admin
  class <%= class_name.pluralize %>Controller < AdminController
    before_action :set_<%= class_name.underscore %>, only: %i[show edit destroy update]

     def index
      @<%= class_name.pluralize.underscore %> = <%= class_name %>.order(created_at: :desc)
    end

    def show; end

    def new
      @<%= class_name.underscore %> = <%= class_name %>.new
    end

    def create
      @<%= class_name.underscore %> = <%= class_name %>.new(<%= class_name.underscore %>_params)

      if @<%= class_name.underscore %>.save
        flash[:success] = t('record.created')
        redirect_to admin_<%= class_name.underscore.pluralize %>_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @<%= class_name.underscore %>.update(<%= class_name.underscore %>_params)
        flash[:success] = t('record.updated')
        redirect_to admin_<%= class_name.underscore %>_path
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      @<%= class_name.underscore %>.destroy
      flash[:success] = t('record.destroyed')

      redirect_to admin_<%= class_name.underscore.pluralize %>_path, status: :see_other
    end

    private

    def set_<%= class_name.underscore %>
      @<%= class_name.underscore %> = <%= class_name %>.find(params[:id])
    end

    def <%= class_name.underscore %>_params
      params.require(:<%= class_name.underscore %>).permit(
        <%-model_columns.each_with_index do |col, index| -%>
         :<%= col %><%=model_columns.count == (index +1) ? '' : ',' %>
         <%- end -%>
        )
    end
  end
end
