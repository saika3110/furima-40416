require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid? #
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '1234'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end  
      
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordは、半角英字のみでは登録できないこと' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters and numbers.')
      end
         
      it 'passwordは、半角数字のみでは登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters and numbers.')
      end 


it 'passwordが半角英数字混合では有効であること' do
            @user.password = 'abc123'
            @user.password_confirmation = 'abc123'
            expect(@user).to be_valid
end
      
      it 'nameカナ(全角)は、名字が必須であること' do
        @user.last_name_kana = nil
        expect(@user).to be_invalid 
      end

      it 'nameカナ(全角)は、名前が必須であること' do
        @user.first_name_kana = nil
        expect(@user).to be_invalid
      end

      it 'name(全角)は、名字が必須であること' do
        @user.last_name = nil
        expect(@user).to be_invalid
      end
      it 'name(全角)は、名前が必須であること' do
        @user.first_name = nil
        expect(@user).to be_invalid
      end

      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Birth date can\'t be blank')
      end
    end
  end
end
