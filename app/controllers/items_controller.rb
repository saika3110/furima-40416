class ItemsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
      #@items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.price = @item.price.to_s.gsub(',', '') if @item.price
    if @item.save
      redirect_to root_path   
    else
      render :new, status: :unprocessable_entity# 保存に失敗したときの処理（出品ページを再度表示する）
    end
  end
  

private

  def item_params
    
    params.require(:item).permit(:image, :item_name, :item_info, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
