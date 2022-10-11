# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do

  let(:query) { '<%= class_name.downcase %>s' }
  let(:data) { json.dig('data', '<%= class_name.downcase %>s', 'nodes') }

  describe 'thematics' do
    it_behaves_like 'with standard user' do
      before do
        5.times do
          Fabricate(:<%= class_name.downcase %>)
        end
        5.times do
          Fabricate(:<%= class_name.downcase %>)
        end
        do_graphql_request
      end

      it 'get a <%= class_name.downcase %>s list' do
        expect(errors).to be_blank
        expect(data.size).to eq(5)
      end
    end
  end

#   describe 'when unauthenticated' do
#     before do
#       do_graphql_request
#     end

#     include_examples 'when unauthenticated'
#   end
end
