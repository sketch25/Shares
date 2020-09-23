FactoryBot.define do
  factory :post do
    title {Faker::Lorem.sentence}
    content {Faker::Lorem.sentence}
    type {Faker::Number.between(from: 0, to: 1)}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end