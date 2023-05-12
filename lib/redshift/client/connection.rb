require 'pg'
require 'forwardable'

module Redshift
  module Client
    class Connection
      extend Forwardable
      attr_reader :original

      def initialize(configuration)
        @original = PG.connect(configuration.params)
        @original.type_map_for_results = PG::BasicTypeMapForResults.new(@original)
      end

      def_delegators \
        :@original,
        :exec,
        :exec_params,
        :escape,
        :escape_string,
        :escape_literal,
        :close,
        :transaction
    end
  end
end
