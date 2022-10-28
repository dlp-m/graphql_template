# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::ForgotPassword, type: :request do
  let(:query) { 'forgotPassword' }
  let(:user) { Fabricate(:user) }

  let(:variables) do
    {
      input: {
        email: user.email
      }
    }
  end

  describe 'Forgot password' do
    it 'return true' do
      do_graphql_request

      expect(errors).to be_blank
      expect(json.dig(:data, :forgotPassword, :done)).to be(true)
    end

    # TODO: uncomment this when mailer is implemented
    # it 'send a mail' do
    #   message_delivery = instance_double(ActionMailer::MessageDelivery)
    #   allow(message_delivery).to receive(:deliver_later)
    #   do_graphql_request

    #   expect(errors).to be_blank

    #   expect(enqueued_jobs.size).to eq(1)
    # end
  end

  describe 'with wrong email' do
    let(:variables) do
      {
        input: {
          email: 'wrong email'
        }
      }
    end

    it "return doesn't send mail" do
      do_graphql_request

      expect(errors).to be_present
      expect(errors.dig(0, :extensions, :code)).to match(/not_found/)

      expect(enqueued_jobs.size).to eq(0)
    end
  end
end
