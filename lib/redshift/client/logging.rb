require 'active_support'
require 'active_support/core_ext/class/attribute_accessors'

module Redshift
  module Client
    module Logging
      cattr_accessor :logger
    end
  end
end
