# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateCurrentUser, type: :request do
  let(:query) { 'updateCurrentUser' }

  let(:variables) do
    {
      input: {
        firstName: 'New first name',
        lastName: 'New last name',
        password: 'my_new_password'
      }
    }
  end

  before { do_graphql_request }

  it_behaves_like 'with standard user' do
    describe 'Update current user' do
      it 'return the updated current user' do
        expect(errors).to be_blank

        data = json.dig(:data, :updateCurrentUser, :user)
        expect(data[:firstName]).to eq('New first name')
        expect(data[:lastName]).to eq('New last name')
        expect(user.reload.authenticated?('my_new_password')).to be(true)
      end
    end

    describe 'with invalid values' do
      let(:variables) do
        {
          input: {
            firstName: 'New first name',
            password: ''
          }
        }
      end

      it 'return an error' do
        expect(errors).to be_present
        expect(errors.dig(0, :message)).to be_present
        expect(user.reload.first_name).not_to eq('New first name') # the valid fields have not been updated
        expect(user.encrypted_password).not_to be_blank # the password has not been nullified
      end
    end
  end

  include_examples 'when unauthenticated'
end
