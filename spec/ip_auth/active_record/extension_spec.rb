require 'spec_helper'
require 'active_record'

describe ActiveRecord::Base do
  it "should respond to ip_authenticatable" do
    ActiveRecord::Base.respond_to?(:ip_authenticatable).should be_true
  end

  it "should not raise exception on including ip_authenticatable to active record subclass" do
    expect do
      class SomeClass < ActiveRecord::Base; ip_authenticatable; end
    end.to_not raise_error
  end
end