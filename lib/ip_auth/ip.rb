module IpAuth
  class Ip
    include IPAddress
    attr_accessor :ip

    def initialize(*args)
      ip_str = args.shift
      ip_str = ip_str.to_string if ip_str.is_a?(IPAddress)
      args.unshift(ip_str)
      @ip = IPAddress *args
    end

    def method_missing(*args)
      self.ip.send(*args)
    end

    def ==(other)
      self.ip == other.ip
    end
    alias_method :eql?, :==

    def to_s
      self.ip.to_s
    end
    alias_method :inspect, :to_s
  end
end
