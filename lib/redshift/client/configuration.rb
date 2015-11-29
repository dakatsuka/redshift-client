require 'uri'
require 'active_support/core_ext/hash/reverse_merge'

module Redshift
  module Client
    class Configuration
      attr_reader :host, :port, :user, :password, :dbname

      class << self
        def resolve(config = {})
          config.reverse_merge!(parse_redshift_url)

          Configuration.new(
            config[:host],
            config[:port],
            config[:user],
            config[:password],
            config[:dbname]
          )
        end

        private
        def parse_redshift_url
          uri = URI.parse(ENV["REDSHIFT_URL"])
          {
            host: uri.host,
            port: uri.port,
            user: uri.user,
            password: uri.password,
            dbname: uri.path[1..-1]
          }
        rescue
          {}
        end
      end

      def initialize(host, port, user, password, dbname)
        @host = host
        @port = port || 5439
        @user = user
        @password = password
        @dbname = dbname
      end

      def params
        {
          host: @host,
          port: @port,
          user: @user,
          password: @password,
          dbname: @dbname
        }
      end
    end
  end
end
