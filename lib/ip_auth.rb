# generale requires
require "active_record"
require "active_support/concern"

# ip_auth requires
require "ip_auth/active_record/extension"
require "ip_auth/ip_config"
require "ip_auth/version"

module IpAuth
end

ActiveRecord::Base.extend IpAuth::ActiveRecord::Extension
