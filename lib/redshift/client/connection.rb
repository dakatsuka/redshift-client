require 'pg'
require 'active_support/core_ext/module'

module Redshift
  module Client
    class Connection
      attr_reader :original

      def initialize(configuration)
        @original = PG.connect(configuration.params)
      end

      delegate \
        :exec,
        :exec_params,
        :escape,
        :escape_string,
        :escape_literal,
        :close,
        to: :original
    end
  end
end
