# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  let(:query) { 'frequentlyAskedQuestions' }
  let(:data) { json.dig(:data, :frequentlyAskedQuestions, :nodes) }

  describe 'frequently_asked_question' do
    it_behaves_like 'with standard user' do
      before do
        5.times do
          Fabricate(:frequently_asked_question)
        end
        do_graphql_request
      end

      it 'get a frequently_asked_questions list' do
        expect(errors).to be_blank
        expect(data.size).to eq(5)
      end
    end
  end

  describe 'when unauthenticated' do
    before do
      do_graphql_request
    end

    include_examples 'when unauthenticated'
  end
end
