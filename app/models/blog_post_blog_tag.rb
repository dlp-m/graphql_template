class BlogPostBlogTag < ApplicationRecord
  # Extensions
  # Enumerize
  # Validations
  # Associations
  belongs_to :blog_tag
  belongs_to :blog_post
  # Callbacks
  # Scopes
  # Supports
  # Public
  # Protected
  # Private
end

# == Schema Information
#
# Table name: blog_post_blog_tags
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  blog_post_id :bigint           not null
#  blog_tag_id  :bigint           not null
#
# Indexes
#
#  index_blog_post_blog_tags_on_blog_post_id  (blog_post_id)
#  index_blog_post_blog_tags_on_blog_tag_id   (blog_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_post_id => blog_posts.id)
#  fk_rails_...  (blog_tag_id => blog_tags.id)
#
