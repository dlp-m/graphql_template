# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do

  let(:query) { '<%= class_name.camelize(:lower) %>s' }
  let(:data) { json.dig('data', '<%= class_name.camelize(:lower) %>s', 'nodes') }

  describe 'thematics' do
    it_behaves_like 'with standard user' do
      before do
        5.times do
          Fabricate(:<%= class_name.underscore %>)
        end
        do_graphql_request
      end

      xit 'get a <%= class_name.underscore %>s list' do
        expect(errors).to be_blank
        expect(data.size).to eq(5)
      end
    end
  end

  RSpec.shared_examples 'when unauthenticated' do
    it 'returns an error' do
      expect(errors).to be_present
      expect(errors.dig(0, 'extensions', 'code')).to eq('unauthorized')
    end
  end
end
