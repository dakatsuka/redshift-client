module Redshift
  module Client
    class RedshiftClientError < StandardError
    end

    class ConfigurationError < RedshiftClientError
    end

    class ConnectionNotEstablished < RedshiftClientError
    end
  end
end
