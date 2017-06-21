require 'uri'
require 'cgi'
require 'active_support/core_ext/hash/reverse_merge'

module Redshift
  module Client
    class Configuration
      attr_reader :host, :port, :user, :password, :dbname

      DEFAULT_SSL_MODE = 'allow'.freeze

      class << self
        def resolve(config = {})
          config.reverse_merge!(parse_redshift_url)

          Configuration.new(
            config[:host],
            config[:port],
            config[:user],
            config[:password],
            config[:dbname],
            config[:sslmode]
          )
        end

        private

        def parse_redshift_url
          uri = URI.parse(ENV['REDSHIFT_URL'])
          {
            host: uri.host,
            port: uri.port,
            user: uri.user,
            password: uri.password,
            dbname: uri.path[1..-1],
            sslmode: sslmode(uri)
          }
        rescue
          {}
        end

        def sslmode(uri)
          if uri.query
            param = CGI.parse(uri.query)['sslmode']
            param && param[0]
          end
        end
      end

      def initialize(host, port, user, password, dbname, sslmode)
        @host = host
        @port = port || 5439
        @user = user
        @password = password
        @dbname = dbname
        @sslmode = sslmode || DEFAULT_SSL_MODE
      end

      def params
        {
          host: @host,
          port: @port,
          user: @user,
          password: @password,
          dbname: @dbname,
          sslmode: @sslmode
        }
      end
    end
  end
end
