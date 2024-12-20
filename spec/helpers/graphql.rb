# frozen_string_literal: true

module Helpers
  module GraphQL
    def id_from_object(object)
      TestGeneratorSchema.id_from_object(object, nil, nil)
    end

    def object_from_id(id)
      TestGeneratorSchema.object_from_id(id, nil)
    end

    def json
      response.parsed_body.deep_symbolize_keys
    end

    def errors
      if described_class.to_s.deconstantize == 'Types'
        query_errors
      else # == 'Mutations'
        mutation_errors
      end
    end

    def query_errors
      json[:errors]
    end

    def mutation_errors
      mutation = described_class.to_s.demodulize.tap { |e| e[0] = e[0].downcase }

      json[:errors] ||  json.dig(:data, mutation.to_sym, :errors)
    end

    def loader
      @loader ||= ::GraphQL::Extras::Test::Loader.new.tap do |loader|
        Dir.glob('spec/fixtures/graphql/**/*.graphql') do |path|
          loader.load(path)
        end
      end
    end

    def query
      nil
    end

    def variables
      {}
    end

    def do_graphql_request
      graphql_query = loader.print(loader.operations[query])
      post(
        '/graphql',
        params: {
          query: graphql_query,
          variables: variables.to_json
        },
        headers:
      )
    end

    # Shared example to test the error returned when giving an invalid ID on a query
    RSpec.shared_examples 'error with invalid ID' do
      let(:variables) { { id: 'foobar' } }

      it 'returns an error' do
        expect(errors).to be_present
        expect(errors.dig(0, :message)).to match(/No object found/)
      end
    end
  end
end
