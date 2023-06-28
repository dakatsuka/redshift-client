require 'pg'

module Redshift
  module Client
    class Connection
      attr_reader :original

      def initialize(configuration)
        @original = PG.connect(configuration.params)
        @original.type_map_for_results = extended_type_map_for(@original)
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

      private

      def extended_type_map_for(connection)
        PG::BasicTypeMapForResults.new(connection, registry: registry)
      end

      def registry
        # PG::BasicTypeMap assumes DB is in the same tz as application
        # This extension supports Database which stores data in UTC if the column type is timezone(without zone)
        timestamp_tz_parser_klass = PG::TextDecoder::TimestampUtcToLocal
        registry = PG::BasicTypeRegistry.new
        registry.register_default_types
        registry.register_type(0, 'timestamp', PG::TextEncoder::TimestampWithoutTimeZone, timestamp_tz_parser_klass)
        registry
      end

    end
  end
end
