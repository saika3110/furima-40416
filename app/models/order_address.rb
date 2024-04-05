class OrderAddress

  include ActiveModel::Model
  #Orderテーブルとaddressesテーブルに保存したいカラム名を、すべて指定(form_withメソッドの引数に指定できるようになります)
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
validates :city, presence: true
validates :address, presence: true
validates :phone_number, presence: true
validates :phone_number, numericality: { message: "is invalid. Input only number" }
validates :phone_number, length: { minimum: 10, maximum: 11 }
validates :user_id, presence: true
validates :item_id, presence: true
validates :token, presence: true
# 数字3桁、ハイフン、数字4桁の並びのみ許可する
validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}

  def save
    # 注文記録管理を保存し、変数Order?に代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # donationの部分を order_id(？)には、変数order(？)のidと指定する
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end