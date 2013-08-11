require 'factory_girl'

FactoryGirl.define do

  factory :organization do
    name "ABC corp"
    root "abc"
  end

  factory :user do
    name "John doe"
    email "john.doe@company.com"
  end
end