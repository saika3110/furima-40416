FactoryBot.define do
  factory :item do
    user { nil }
    item_name { "MyString" }
    item_info { "MyText" }
    price { 1 }
    category_id { 1 }
    condition_id { 1 }
    shipping_cost_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
  end
end
