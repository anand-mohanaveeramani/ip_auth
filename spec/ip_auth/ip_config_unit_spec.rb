require 'spec_helper'

describe IpAuth::IpConfigUnit do
  context "basic validations" do
    it "should have a valid type" do
      expect{IpAuth::IpConfigUnit.new({a: 1})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({network: "something"})}.to raise_error
      expect{IpAuth::IpConfigUnit.new({type: "random"})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
    end

    it "range type should have a start address and end address to be valid" do
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "192.168.10.1"})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, end: "192.168.10.100"})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "error", end: "192.168.10.100"})}.to raise_error
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "192.168.10.1", end: "192.168.10.100"})}.to_not raise_error
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "192.168.10.1", end: IpAuth::Ip.new("192.168.10.100")})}.to_not raise_error
    end

    it "range type should have a network address to be valid" do
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, network: "192.168.10.1/24"})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, network: "192.168.10.0/24"})}.to_not raise_error
    end

    it "single type should have ip" do
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::SINGLE})}.to raise_error(IpAuth::Exception::IpConfigUnitError)
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::SINGLE, ip: "invalid"})}.to raise_error
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::SINGLE, ip: "192.168.7.11"})}.to_not raise_error
    end
  end

  context "processing" do
    it "single type should allow if matched" do
      icu = IpAuth::IpConfigUnit.new({type: IpAuth::Type::SINGLE, ip: "192.168.7.11"})
      ip1 = IpAuth::Ip.new("192.168.7.10")
      ip2 = IpAuth::Ip.new("192.168.7.11")
      ip3 = IpAuth::Ip.new("192.168.7.12")
      icu.allow?(ip1).should be_false
      icu.allow?(ip2).should be_true
      icu.allow?(ip3).should be_false
    end

    it "range type should allow if contained in start and end range" do
      icu = IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "192.168.7.10", end: "192.168.7.12"})
      ip1 = IpAuth::Ip.new("192.168.7.9")
      ip2 = IpAuth::Ip.new("192.168.7.10")
      ip3 = IpAuth::Ip.new("192.168.7.11")
      ip4 = IpAuth::Ip.new("192.168.7.12")
      ip5 = IpAuth::Ip.new("192.168.7.13")
      icu.allow?(ip1).should be_false
      icu.allow?(ip2).should be_true
      icu.allow?(ip3).should be_true
      icu.allow?(ip4).should be_true
      icu.allow?(ip5).should be_false
    end

    it "range type should allow if conatined in network" do
      icu = IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, network: "192.168.7.8/30"})
      ip1 = IpAuth::Ip.new("192.168.7.7")
      ip2 = IpAuth::Ip.new("192.168.7.8")
      ip3 = IpAuth::Ip.new("192.168.7.9")
      ip4 = IpAuth::Ip.new("192.168.7.10")
      ip5 = IpAuth::Ip.new("192.168.7.11")
      ip6 = IpAuth::Ip.new("192.168.7.12")
      icu.allow?(ip1).should be_false
      icu.allow?(ip2).should be_true
      icu.allow?(ip3).should be_true
      icu.allow?(ip4).should be_true
      icu.allow?(ip5).should be_true
      icu.allow?(ip6).should be_false
    end
  end
end