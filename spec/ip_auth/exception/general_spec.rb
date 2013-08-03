require 'spec_helper'

describe IpAuth::Exception::General do
  it "is just a standard error object" do
    ieg = IpAuth::Exception::General.new("test")
    ieg.to_s.should eq("test")
    ieg.message.should eq("test")
    expect {raise ieg}.to raise_error(IpAuth::Exception::General)
  end
end