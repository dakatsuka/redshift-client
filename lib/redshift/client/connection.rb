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

      def method_missing(method_name, *args, &block)
        if @original.respond_to?(method_name)
          @original.send(method_name, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        @original.respond_to?(method_name, include_private) || super
      end
    end
  end
end
