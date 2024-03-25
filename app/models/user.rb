class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
validates :nickname,
            :last_name_kana,
            :first_name_kana,
            :last_name,
            :first_name,
            :birth_date,
            :email, presence: true

  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Input half-width characters and numbers.' }
  validates :password_confirmation, presence: true
end