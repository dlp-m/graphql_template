# frozen_string_literal: true

class BlogTag < ApplicationRecord
  # Extensions
  # Enumerize
  # Validations
  validates :name, presence: true
  # Associations
  has_many :blog_posts, dependent: :nullify
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
