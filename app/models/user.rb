class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/

VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ー]+\z/
VALID_KANA_REGEX = /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/
VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
validates :nickname, presence: true

validates :last_name_kana, :first_name_kana, format: { with: VALID_KANA_REGEX, message: '全角カタカナ使用してください' }
validates :last_name_kana, :first_name_kana, format: { with: VALID_KANA_REGEX, message: '全角ひらがなのみで入力して下さい' }      
validates :last_name_kana, :first_name_kana, format: { with: VALID_KANA_REGEX, message: '半角英字を使用してください' } 
validates :last_name_kana, format: { with: VALID_KANA_REGEX, message: '全角カタカナ使用してください' }

validates :last_name, :first_name, format: { with: VALID_NAME_REGEX, message: '全角（漢字・ひらがな・カタカナ）を使用してください' }
validates :last_name, :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: '全角（漢字・ひらがな・カタカナ）を使用してください' }

validates :birth_date, presence: true
validates :email, presence: true
validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Input half-width characters and numbers.' }

end