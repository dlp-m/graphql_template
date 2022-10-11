module Admin
  class <%= class_name.pluralize %>Controller < AdminController
    before_action :set_<%= class_name.downcase %>, only: %i[show edit destroy update]

     def index
      @<%= class_name.pluralize.downcase %> = <%= class_name %>.order(created_at: :desc)
    end

    def show; end

    def new
      @<%= class_name.downcase %> = <%= class_name %>.new
    end

    def create
      @<%= class_name.downcase %> = <%= class_name %>.new(<%= class_name.downcase %>_params)

      if @<%= class_name.downcase %>.save
        flash[:success] = t('record.created')
        redirect_to admin_<%= class_name.downcase.pluralize %>_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @<%= class_name.downcase %>.update(<%= class_name.downcase %>_params)
        flash[:success] = t('record.updated')
        redirect_to admin_<%= class_name.downcase %>_path
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      @<%= class_name.downcase %>.destroy
      flash[:success] = t('record.destroyed')

      redirect_to admin_<%= class_name.downcase.pluralize %>_path, status: :see_other
    end

    private

    def set_<%= class_name.downcase %>
      @<%= class_name.downcase %> = <%= class_name %>.find(params[:id])
    end

    def <%= class_name.downcase %>_params
      params.require(:<%= class_name.downcase %>).permit(:title, :video_url, :content, :created_at, :thumbnail, :picture, :full_name,
                                          :job)
    end
  end
end
