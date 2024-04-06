FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '00000000000' }
    token { SecureRandom.urlsafe_base64 }  

    after(:build) do |order_address|
    user = create(:user)
    item = create(:item)
    order_address.user_id = user.id
    order_address.item_id = item.id
    end
  end
end
