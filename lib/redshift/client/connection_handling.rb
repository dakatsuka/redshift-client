require 'thread'

module Redshift
  module Client
    module ConnectionHandling
      def establish_connection(config = {})
        clear_connection!
        clear_thread!

        current[:configuration] = Configuration.resolve(config)
      end

      def connection
        return current[:connection] if connected?

        check_established!
        current[:connection] = Connection.new(current[:configuration])
        current[:connection]
      end

      def disconnect
        clear_connection!
      end

      def established?
        !! current[:configuration]
      end

      def connected?
        !! current[:connection]
      end

      private
      def check_established!
        raise ConnectionNotEstablished.new unless established?
      end

      def clear_connection!
        current[:connection] && current[:connection].close
        current[:connection] = nil
      end

      def clear_thread!
        Thread.current[:redshift] = nil
      end

      def current
        Thread.current[:redshift] ||= {}
      end
    end
  end
end
