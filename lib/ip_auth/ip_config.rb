module IpAuth
  class IpConfig < ::ActiveRecord::Base
    # internal constants
    IP_CONFIG_UNIT_SEPARATOR = "<>"

    # accessors
    attr_accessor :decoded_setting, :decoded_setting_valid

    # associations
    belongs_to :ip_authenticatable, polymorphic: true

    # methods

    def configuration(options = {})
      begin
        case options[:method]
        when :get
          get_configuration(options)
        when :set
          set_configuration(options)
        end
      rescue => error
        options[:raise] ? raise(error) : false
      end
    end

    def get_configuration(options = {})
      update_decoded_setting unless @decoded_setting_valid
      @decoded_setting
    end

    def set_configuration(options = {})
      @decoded_setting_valid = false
      self.update(setting: get_encoded_string(options[:config]))
      get_configuration(options)
    end

    def get_encoded_string(conf)
      conf.collect(&:to_json).join(IP_CONFIG_UNIT_SEPARATOR)
    end

    def update_decoded_setting
      @decoded_setting = []
      self.setting.split(IP_CONFIG_UNIT_SEPARATOR).each do |unit_str|
        @decoded_setting << IpAuth::IpConfigUnit.new(JSON.load(unit_str))
      end
      @decoded_setting_valid = true
    end
  end
end