# generale requires
require "active_record"
require "active_support"
require "active_support/concern"
require "ipaddr"

# ip_auth requires
require "ip_auth/active_record/extension"
require "ip_auth/ip"
require "ip_auth/ip_config"
require "ip_auth/ip_config_unit"
require "ip_auth/version"

module IpAuth
end

ActiveRecord::Base.extend IpAuth::ActiveRecord::Extension
