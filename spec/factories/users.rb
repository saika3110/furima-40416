FactoryBot.define do
  factory :user do
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_name_kana {"ヤマダ"}
    first_name_kana {"タロウ"}
    nickname {Faker::Name.first_name} 
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    birth_date {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end