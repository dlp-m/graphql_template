class FrequentlyAskedQuestion < ApplicationRecord
  # Extensions
  acts_as_list
  # Enumerize
  # Validations
  validates :title, presence: true
  validate :content_present
  # Associations
  has_rich_text :content
  # Callbacks
  before_save :set_position
  # Scopes
  # Supports
  # Public
  def content_present
    errors.add(:content, "can't be empty") if content.blank?
  end
  # Protected
  # Private

  private

  def set_position
    max_position = FrequentlyAskedQuestion.maximum(:position) || 0
    return if position.present? && position <= max_position

    self.position = persisted? ? max_position : max_position + 1
  end
end

# == Schema Information
#
# Table name: frequently_asked_questions
#
#  id         :bigint           not null, primary key
#  position   :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
