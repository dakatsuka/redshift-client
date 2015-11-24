require 'active_support'
require 'active_support/core_ext/class/attribute_accessors'
require 'logger'

module Redshift
  module Client
    module Loggable
      def logger
        @logger || create_default_logger
      end

      private
      def create_default_logger
        @logger = Logger.new($stdout)
        @logger.level = Logger::INFO
        @logger
      end
    end
  end
end
