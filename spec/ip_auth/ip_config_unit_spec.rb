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
      expect{IpAuth::IpConfigUnit.new({type: IpAuth::Type::RANGE, start: "192.168.10.1", end: "192.168.10.100"})}.to_not raise_error
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
end