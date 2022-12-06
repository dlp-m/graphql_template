# frozen_string_literal: true

if Rails.env.development?
  %w[
    Travel
    Music
    Lifestyle
    Fitness
    DIY
    Sports
    Web
  ].each do |cat|
    BlogCategory.find_or_create_by(name: cat)
  end
  %w[one two three four five six seven eight nine ten].each do |tag|
    BlogTag.find_or_create_by(name: tag)
  end
  BlogCategory.find_each do |category|
    post = BlogPost.create!(
      blog_category: category,
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      administrator: Administrator.all.sample
    )
    post.blog_tags << BlogTag.all.sample(3)
  end
end
