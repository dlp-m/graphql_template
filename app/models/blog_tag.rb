# frozen_string_literal: true

class BlogTag < ApplicationRecord
  # Extensions
  # Enumerize
  # Validations
  validates :name, presence: true
  # Associations
  has_many :blog_post_blog_tags,
          class_name: 'BlogPostBlogTag',
          dependent: :destroy
  has_many :blog_posts,
           through: :blog_post_blog_tags,
           source: :blog_post,
           class_name: 'BlogPost'
  # Callbacks
  # Scopes
  # Supports
  # Public
  # Protected
  # Private
end

# == Schema Information
#
# Table name: blog_tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
