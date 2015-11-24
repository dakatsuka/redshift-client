require "redshift/client/version"
require "redshift/client/errors"
require "redshift/client/configuration"
require 'redshift/client/loggable'
require "redshift/client/connection"
require "redshift/client/connection_handling"

module Redshift
  module Client
    extend Loggable
    extend ConnectionHandling
  end
end
