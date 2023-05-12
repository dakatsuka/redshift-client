require 'pg'
require 'forwardable'

module Redshift
  module Client
    class Connection
      extend Forwardable
      attr_reader :original

      def initialize(configuration)
        @original = PG.connect(configuration.params)
      end

      def_delegators \
        :@original,
        :exec,
        :exec_params,
        :escape,
        :escape_string,
        :escape_literal,
        :close
    end
  end
end
