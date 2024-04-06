class OrderAddress

  include ActiveModel::Model
  #Orderテーブルとaddressesテーブルに保存したいカラム名を、すべて指定(form_withメソッドの引数に指定できるようになります)
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

with_options presence: true do
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :city
  validates :address
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only 10 or 11 numbers" }
  validates :user_id
  validates :item_id
  validates :token
end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    # 注文記録管理を保存し、変数Order?に代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # donationの部分を order_id(？)には、変数order(？)のidと指定する
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end