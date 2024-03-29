FactoryBot.define do
  factory :item do
    item_name { "MyString" }
    item_info { "MyText" }
    price { 301 }
    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg')) }
    association :user 
  end
end
