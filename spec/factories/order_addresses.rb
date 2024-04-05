FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { 00000000000 }
    user_id { FactoryBot.create(:user).id } # user_idを追加
    item_id { FactoryBot.create(:item).id } # item_idを追加
    token { SecureRandom.urlsafe_base64 }  # tokenを追加 
  end
end
