# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ResetPassword, type: :request do
  let(:query) { 'resetPassword' }
  let(:user) { Fabricate(:user) }
  let(:reset_token) { user.confirmation_token }
  let(:password) { Faker::Internet.password(min_length: 8) }

  let(:variables) do
    {
      input: {
        resetToken: reset_token,
        password:
      }
    }
  end

  describe 'reset password' do
    before do
      user.forgot_password!
    end

    it 'return true' do
      do_graphql_request

      expect(errors).to be_blank
      expect(json.dig(:data, :resetPassword, :passwordReset)).to be(true)
    end

    context 'when password is empty' do
      let(:password) { '' }

      it 'return false' do
        do_graphql_request

        expect(errors).to be_blank
        expect(json.dig(:data, :resetPassword, :passwordReset)).to be(false)
      end
    end
  end

  describe 'with wrong token' do
    let(:reset_token) { 'wrong token' }

    it 'return false' do
      do_graphql_request

      expect(errors).to be_present
      expect(errors.dig(0, :extensions, :code)).to match(/not_found/)
    end
  end
end
