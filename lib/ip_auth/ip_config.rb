module IpAuth
  class IpConfig < ::ActiveRecord::Base
    belongs_to :ip_authenticatable, polymorphic: true
  end
end