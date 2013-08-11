# generale requires
require "active_record"
require "active_support"
require "active_support/concern"
require "ipaddress"

# ip_auth requires
require "ip_auth/active_record/extension"
require "ip_auth/exception/general"
require "ip_auth/exception/ip_config_unit_error"
require "ip_auth/ip"
require "ip_auth/ip_config"
require "ip_auth/ip_config_unit"
require "ip_auth/version"

module IpAuth
  module Type
    RANGE = :range
    SINGLE = :single

    def self.all
      [RANGE, SINGLE]
    end
  end
end

ActiveRecord::Base.extend IpAuth::ActiveRecord::Extension
