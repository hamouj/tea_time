FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Cofee.notes }
    temperature { Faker::Number.between(from: 170, to: 212) }
    brew_time { Faker::Number.between(from: 1, to: 5) }
  end
end
