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
        @user.valid? 
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
      
      it 'passwordは、全角文字では登録できないこと' do
        @user.password = 'パスワード'
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters and numbers.')
      end


      it 'last_name（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角（漢字・ひらがな・カタカナ）を使用してください")
      end                                               

      it 'first_name（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）を使用してください")
      end


      it 'last_name_kanaは、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'smith' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナ使用してください" )
      end

      it'first_name_kanaは、全角（カタカナ）での入力が必須であること'do
        @user.first_name_kana = 'john'  
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナ使用してください")
      end

      it 'last_name_kanaは、全角（ひらがな）での入力が必須であること' do
        @user.last_name_kana = 'すみす' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角ひらがなのみで入力して下さい")
      end

      it'first_name_kanaは、全角（ひらがな）での入力が必須であること'do
        @user.first_name_kana = 'じょん'  
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角ひらがなのみで入力して下さい")
      end

      it'last_name_kanaは、半角英字での入力が必須であること'do
        @user.last_name_kana = 'smith'  
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 半角英字を使用してください")
      end

      it'first_name_kanaは、半角英字での入力が必須であること'do
        @user.first_name_kana = 'john'  
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 半角英字を使用してください")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kana(全角)は、名字が必須であること' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナ使用してください")
      end

      it 'first_name_kana(全角)は、名前が必須であること' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナ使用してください")
      end

      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
