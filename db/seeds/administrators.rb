# frozen_string_literal: true

if Rails.env.development?
 %w[dev@tymate.com admin@tymate.com].each do |email|
    Administrator.find_or_create_by(
      email: email, first_name: 'dev', last_name: 'tymate'
    )
  end
end
