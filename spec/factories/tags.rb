FactoryBot.define do
  factory :tag do
    name {Faker::Alphanumeric.alpha(number: 50)}
  end
end