module IpAuth
  module ActiveRecord
    module Extension
      extend ActiveSupport::Concern

      def ip_authenticatable
        class_eval do
          has_many :ip_configs, as: :ip_authenticatable, dependent: :destroy, class_name: "IpAuth::IpConfig"
        end
      end
    end
  end
end