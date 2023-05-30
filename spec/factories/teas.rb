FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Cofee.notes }
    temperature { Faker::Number.between(from: 170.00, to: 212.00) }
    brew_time { Faker::Number.between(from: 60, to: 240) }
  end
end
