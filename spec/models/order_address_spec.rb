require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id)
  end

  describe '商品購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        @order_address.phone_number = '09012345678'
        expect(@order_address).to be_valid
      end
      
      it 'building_name（建物名）は空でも保存できること' do
        @order_address.building_name = ''
        @order_address.phone_number = '09012345678'
        expect(@order_address).to be_valid
      end
      it 'phone_numberが10桁以上であれば保存できる' do
        @order_address.phone_number = '09012345678'
        expect(@order_address).to be_valid
      end
      it 'item_idとtokenが空でない場合、保存できる' do
          user = FactoryBot.create(:user)
          item = FactoryBot.create(:item)
          @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
          @order_address.phone_number = '09012345678'
          expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_code（郵便番号）が空だと保存できないこと' do
          @order_address.postal_code = nil   
          @order_address.valid?
          p @order_address.errors.full_messages 
          expect(@order_address.errors.full_messages).to include("Postal code can't be blank")      
      end

      it 'postal_code（郵便番号）が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
          @order_address.postal_code = '1234567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'prefecture（都道府県）を選択していないと保存できないこと' do
          @order_address.prefecture_id = 1
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'city（市区町村）が空だと保存できないこと' do
          @order_address.city = ""
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'address（番地）が空だと保存できないこと' do
          @order_address.address = ""
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_number（電話番号）が空だと保存できないこと' do
          @order_address.phone_number = ""
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_number（電話番号）が9桁以下だと保存できないこと' do
          @order_address.phone_number = '123456789' # 9桁の数字
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only 10 or 11 numbers")
      end

      it 'phone_number（電話番号）が12桁以上だと保存できないこと' do
          @order_address.phone_number = '123456789012' # 12桁の数字
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only 10 or 11 numbers")
      end

      it 'phone_number（電話番号）に半角数字以外が含まれると保存できないこと' do
          @order_address.phone_number = '123456abcd' # 半角数字以外の文字を含む
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only 10 or 11 numbers")
      end

      it 'userが紐付いていないと保存できないこと' do
          @order_address.user_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
          @order_address.item_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'token（トークン）が空だと保存できないこと' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
