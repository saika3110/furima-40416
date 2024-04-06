FactoryBot.define do
  factory :user do
    
    last_name { '田中' } 
    first_name { '太郎' } 
    
    last_name_kana {"ヤマダ"}
    first_name_kana {"タロウ"}
    nickname {Faker::Name.first_name} 
    email {Faker::Internet.email}

    password { "#{Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 1, min_numeric: 1)}A1" }
    password_confirmation {password}
    birth_date {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end