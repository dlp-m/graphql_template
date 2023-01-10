# frozen_string_literal: true

Fabricator(:frequently_asked_question) do
  title { Faker::Name.name }
  content { Faker::Lorem.paragraph }
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
