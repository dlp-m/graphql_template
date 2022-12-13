# frozen_string_literal: true

if Rails.env.development?
  (1..10).each do |i|
    FrequentlyAskedQuestion.find_or_create_by(title: i).update!(
      content: i,
    )
  end
end
