FactoryBot.define do
  factory :subscription do
    title { Faker::Restaurant.name }
    price { Faker::Number.between(from: 1000, to: 6000) }
    status { "live" }
    frequency { Faker::Number.between(from: 1, to: 5) }

    trait :inactive do
      status { "inactive" }
    end

    factory :inactive_subscription, traits: [:inactive]
  end
end
