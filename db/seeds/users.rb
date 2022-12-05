# frozen_string_literal: true

if Rails.env.development?
 %w[dev@tymate.com admin@tymate.com].each do |email|
    User.find_or_create_by(email: email).update!(password: 'password')
  end
end

