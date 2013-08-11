module IpAuth
  class IpConfigUnit < ActiveSupport::HashWithIndifferentAccess
    def initialize(*args)
      super(*args)
      validate!
      build!
    end

    def allow?(ip)
      case self[:type]
      when IpAuth::Type::SINGLE
        allow_single?(ip)
      when IpAuth::Type::RANGE
        allow_range?(ip)
      end
    end

    private

      def validate!
        hsh = self
        raise IpAuth::Exception::IpConfigUnitError.new("Config type not present") unless hsh[:type]
        hsh[:type] = hsh[:type].to_sym
        case hsh[:type]
        when IpAuth::Type::SINGLE
          raise IpAuth::Exception::IpConfigUnitError.new("ip value missing") unless hsh[:ip]
        when IpAuth::Type::RANGE
          raise IpAuth::Exception::IpConfigUnitError.new("invalid configuration parameters for range type") unless hsh[:network] || (hsh[:start].present? && hsh[:end].present?)
          raise IpAuth::Exception::IpConfigUnitError.new("invalid network address") if hsh[:network] && IpAuth::Ip.new(hsh[:network]).network? == false
        else
          raise IpAuth::Exception::IpConfigUnitError.new("Invalid config type")
        end
      end

      def build!
        hsh = self
        [:ip, :start, :end, :network].each do |key|
          hsh[key] = IpAuth::Ip.new(hsh[key]) if hsh[key]
        end
      end

      def allow_single?(ip)
        self[:ip] == ip
      end

      def allow_range?(ip)
        if self[:network].present?
          self[:network].include?(ip)
        elsif self[:start].present? && self[:end].present?
          (self[:start] <= ip && ip <= self[:end])
        end
      end
  end
end