FactoryBot.define do
  factory :subscription do
    association :tea

    title { Faker::Restaurant.name }
    price { Faker::Number.between(from: 1000, to: 6000) }
    status { "active" }
    frequency { Faker::Number.between(from: 1, to: 5) }

    trait :cancelled do
      status { "packaged" }
    end

    factory :cancelled_package, traits: [:cancelled]
  end
end
