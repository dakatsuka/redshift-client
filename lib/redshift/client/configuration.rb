module Redshift
  module Client
    class Configuration
      attr_reader :host, :port, :user, :password, :dbname

      def self.parse(config)
        if config.empty?
          url = URI.parse(ENV["REDSHIFT_URL"])
          self.new(url.host, url.port, url.user, url.password, url.path[1..-1])
        else
          self.new(config[:host], config[:port], config[:user], config[:password], config[:dbname])
        end
      rescue => e
        raise ConfigurationError.new(e.message)
      end

      def initialize(host, port, user, password, dbname)
        @host = host
        @port = port || 5439
        @user = user
        @password = password
        @dbname = dbname
      end

      def to_hash
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
