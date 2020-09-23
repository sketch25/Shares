FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)
    name                  {Faker::Alphanumeric.alpha(number: 12)}
    nickname              {Faker::Name.last_name}
    sequence(:email)      {Faker::Internet.email}
    password              {password}
    password_confirmation {password}
    icon                  {File.open("#{Rails.root}/public/images/test_image.jpg")}
    profile               {Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)}
  end

end