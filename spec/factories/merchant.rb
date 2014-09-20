FactoryGirl.define do
  factory :merchant do
    name    'Merchant'
    sequence(:email_address) { |n| "test#{n}@test.com" }
    ttl     0
  end
end
