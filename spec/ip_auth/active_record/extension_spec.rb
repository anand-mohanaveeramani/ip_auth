require 'spec_helper'
require 'active_record'

describe ActiveRecord::Base do
  it "should respond to ip_authorizable" do
    ActiveRecord::Base.respond_to?(:ip_authorizable).should be_true
  end

  it "should not raise exception on including ip_authorizable to active record subclass" do
    expect do
      class SomeClass < ActiveRecord::Base; ip_authorizable; end
    end.to_not raise_error
  end

  context "testing interface on a ip authorizable model" do
    before(:each) do
      clean_database!
      @org = create :organization
      ip_start = "10.0.0.0"
      ip_end = "10.0.0.10"
      @test_settings_1 = [{type: IpAuth::Type::RANGE, start: ip_start, end: ip_end}]
      @test_settings_1_expect = [{type: IpAuth::Type::RANGE, start: IpAuth::Ip.new(ip_start), end: IpAuth::Ip.new(ip_end)}].map{|h| h.stringify_keys }
    end

    it "should respond to get_ip_config" do
      @org.respond_to?(:get_ip_config).should be_true
      @org.get_ip_config.should eq([])
    end

    it "should respond to set_ip_config" do
      @org.respond_to?(:set_ip_config).should be_true
      @org.set_ip_config @test_settings_1
      @org.get_ip_config.should eq(@test_settings_1_expect)
    end

    it "should repond to failure of set_ip_config with false" do
      @org.set_ip_config(1).should be_false
    end

    it "should respond to set_ip_config bang" do
      @org.respond_to?(:set_ip_config!).should be_true
      @org.set_ip_config! @test_settings_1
      @org.get_ip_config.should eq(@test_settings_1_expect)
    end

    it "should repond to failure of set_ip_config! with exception" do
      expect { @org.set_ip_config!(1) }.to raise_error(IpAuth::Exception::General)
    end
  end
end