# frozen_string_literal: true

require_relative 'seeds/users'
if Rails.env.development?
  Doorkeeper::Application.find_or_create_by!(
  name: 'front-app',
  uid: 'tGhT2JBVw1dqUtNSJf1Uibu1c8MnMpd5LXXFKSsVLq8',
  secret: '5EYlm_7CByaoSeSk2XX7rOaOdq_BSwihb55ukCNHVCo',
  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
  confidential: false
)
end
