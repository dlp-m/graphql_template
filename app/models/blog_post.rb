# frozen_string_literal: true

class BlogPost < ApplicationRecord
  # Extensions
  extend FriendlyId
  friendly_id :title, use: :slugged
  # Enumerize
  # Validations
  validates :title, :content, presence: true
  validates :meta_title, :meta_description, presence: true
  # Associations
  belongs_to :administrator
  belongs_to :blog_category
  has_rich_text :content
  has_one_attached :cover_picture
  has_many :blog_post_blog_tags,
           class_name: 'BlogPostBlogTag',
           dependent: :destroy
  has_many :blog_tags,
           through: :blog_post_blog_tags,
           source: :blog_tag,
           class_name: 'BlogTag'
  # SEO fields
  validates :slug, presence: true, uniqueness: true
  validates :meta_title, :meta_description, presence: true
  # Callbacks
  # Scopes
  # Supports
  # Public
  # Protected
  # Private
  private
  def should_generate_new_friendly_id?
    title_changed?
  end
end

# == Schema Information
#
# Table name: blog_posts
#
#  id               :bigint           not null, primary key
#  meta_description :text             not null
#  meta_keywords    :string           not null
#  meta_title       :string           not null
#  publication_date :datetime
#  slug             :string
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  administrator_id :bigint           not null
#  blog_category_id :bigint           not null
#
# Indexes
#
#  index_blog_posts_on_administrator_id  (administrator_id)
#  index_blog_posts_on_blog_category_id  (blog_category_id)
#  index_blog_posts_on_slug              (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (administrator_id => administrators.id)
#  fk_rails_...  (blog_category_id => blog_categories.id)
#
