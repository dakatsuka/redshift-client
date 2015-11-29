module Redshift
  module Client
    class RedshiftClientError < StandardError
    end

    class ConnectionNotEstablished < RedshiftClientError
    end
  end
end
