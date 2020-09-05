FactoryBot.define do
  factory :post do
    title {Faker::Lorem.sentence}
    content {Faker::Lorem.sentence}
    type {Faker::Number.between(from: 0, to: 1)}
    hashtag {nil}
    user
  end
end