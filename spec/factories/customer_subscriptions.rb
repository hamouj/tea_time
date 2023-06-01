FactoryBot.define do
  factory :customer_subscription do
    association :customer
    association :subscription
    status { "active" }

    trait :cancelled do
      status { "cancelled" }
    end

    factory :cancelled_subscription, traits: [:cancelled]
  end
end
