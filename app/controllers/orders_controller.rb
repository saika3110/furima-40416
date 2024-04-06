class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: :index

  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

    private

    def move_to_index
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token:params[:token])
  end

  def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount:@item.price,                 # 商品の値段ではなフリマでは購入される商品のデータから取得。
        card: order_address_params[:token], # カードトークン
        currency: 'jpy'                     # 通貨の種類（日本円）
      )
  end

end
