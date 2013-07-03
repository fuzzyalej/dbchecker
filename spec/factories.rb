require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:name){|n| "Mr. User #{n}"}
    sequence(:email){|n| "test-#{n}@redradix.com"}
  end

  factory :profile do
  end
end
