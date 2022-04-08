RSpec.shared_context 'with standard user' do
  let(:application) { Fabricate(:application) }
  let(:user)  { Fabricate(:user) }
  let(:token) { Fabricate(:token, user: user, application: application) }
  let(:headers) { { Authorization: "Bearer #{token.token}" } }
end
