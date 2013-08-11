require 'spec_helper'

describe IpAuth::Ip do
  it "should initialize from string ip" do
    ip_auth_ip_obj = IpAuth::Ip.new "192.168.2.0/24"
    ip_auth_ip_obj.to_string.should eq("192.168.2.0/24")
  end

  it "should initialize from IPAddr object" do
    ip_address_obj = IPAddress.parse "192.168.2.0/24"
    ip_auth_ip_obj = IpAuth::Ip.new ip_address_obj
    ip_auth_ip_obj.to_string.should eq("192.168.2.0/24")
  end
end