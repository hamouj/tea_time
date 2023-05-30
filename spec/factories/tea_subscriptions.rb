FactoryBot.define do
  factory :tea_subscription do
    association :tea
    association :subscription
  end
end
