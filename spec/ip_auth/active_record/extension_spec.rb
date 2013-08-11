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
    end

    it "" do
    end
  end
end