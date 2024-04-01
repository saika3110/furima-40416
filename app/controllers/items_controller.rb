class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]


  def index
    @items = Item.includes(:user).order("created_at DESC")
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
  

  def show
  end
  
  def edit   
  end

  def update         # @item = Item.find(params[:id])の部分は「set_itemメソッドに移行」
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end


  #def sold_out?購入管理機能時の実装で使用
    #!!self.order
  #end

private

    def set_item
      @item = Item.find(params[:id])
    end

    def move_to_index
      redirect_to action: :index unless current_user.id == @item.user_id
    end

    def item_params
    params.require(:item).permit(:image,:item_name,:item_info,:category_id,:condition_id,:shipping_cost_id,:prefecture_id,:shipping_day_id,:price).merge(user_id: current_user.id)
    end
  end
