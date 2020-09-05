FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)
    name {Faker::Name.last_name}
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
    icon {File.open("#{Rails.root}/public/images/test_image.jpg")}
    profile {Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false)}
  end

end