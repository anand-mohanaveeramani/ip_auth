module IpAuth
  module ActiveRecord
    module Extension
      extend ActiveSupport::Concern

      def ip_authorizable
        class_eval do
          has_one :ip_config, as: :ip_authorizable, dependent: :destroy, class_name: "IpAuth::IpConfig"

          def get_ip_config(options = {})
            ip_conf = get_or_create_ip_config
            options.merge!(method: :get)
            options.reverse_merge!(raise: true)
            ip_conf.configuration(options)
          end

          def set_ip_config!(config, options = {})
            ip_conf = get_or_create_ip_config
            options.merge!(method: :set, config: config)
            options.reverse_merge!(raise: true)
            ip_conf.configuration(options)
          end

          def set_ip_config(config, options = {})
            set_ip_config!(config, options.merge(raise: false))
          end

          private

            def get_or_create_ip_config
              IpAuth::IpConfig.where(ip_authorizable: self).first_or_create(setting: "")
            end
        end
      end
    end
  end
end