# frozen_string_literal: true

module Administrators
  class BlogPostsController < AdministratorController
    before_action :set_blog_post, only: %i[show edit destroy update]

    def index
      @q = authorized_scope(
        BlogPost.all,
        with: Bo::Administrators::BlogPostPolicy
      ).ransack(params[:q])
      @pagy, @blog_posts = pagy(@q.result(distinct: true))
    end

    def show
      authorize! @blog_post, to: :show?, namespace:, strict_namespace: true
    end

    def new
      @blog_post = BlogPost.new
      authorize! @blog_post, to: :new?, namespace:, strict_namespace: true
    end

    def edit
      authorize! @blog_post, to: :edit?, namespace:, strict_namespace: true
    end

    def create
      @blog_post = BlogPost.new(blog_post_params)
      authorize! @blog_post, to: :create?, namespace:, strict_namespace: true

      if @blog_post.save
        flash[:success] = t('bo.record.created')
        redirect_to administrators_blog_posts_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize! @blog_post, to: :update?, namespace:, strict_namespace: true

      if @blog_post.update(blog_post_params)
        flash[:success] = t('bo.record.updated')
        redirect_to administrators_blog_post_path
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      authorize! @blog_post, to: :destroy?, namespace:, strict_namespace: true

      @blog_post.destroy
      flash[:success] = t('bo.record.destroyed')

      redirect_to administrators_blog_posts_path, status: :see_other
    end

    def export_csv
      @blog_posts = fetch_authorized_blog_posts
      csv_data = generate_csv_data

      send_data csv_data,
                type: 'text/csv; charset=utf-8; header=present',
                disposition: "attachment; filename=#{I18n.t('bo.blog_post.others')}_#{Time.zone.now}.csv"
    end

    private

    def fetch_authorized_blog_posts
      authorized_scope(
        BlogPost.all,
        with: Bo::Administrators::BlogPostPolicy
      ).ransack(params[:q]).result(distinct: true)
    end

    def generate_csv_data
      CSV.generate(headers: true) do |csv|
        csv << translated_headers

        @blog_posts.each do |instance|
          csv << BlogPost.column_names.map { |col| instance.send(col) }
        end
      end
    end

    def translated_headers
      BlogPost.column_names.map do |col|
        I18n.t("bo.blogpost.attributes.#{col}")
      end
    end

    def set_blog_post
      @blog_post = authorized_scope(
        BlogPost.all,
        with: Bo::Administrators::BlogPostPolicy
      ).friendly.find(params[:id])
    end

    def blog_post_params
      params.require(:blog_post).permit(
        :title,
        :administrator_id,
        :blog_category_id,
        :slug,
        :meta_title,
        :meta_description,
        :meta_keywords,
        :picture,
        :content,
        :publication_date,
        :published,
        blog_post_blog_tag_ids: %i[],
        blog_tag_ids: %i[]
      )
    end
  end
end
