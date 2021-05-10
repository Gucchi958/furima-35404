class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname        
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i, message: "は6文字以上かつ半角英数字をそれぞれ含めてください" }
    validates :birthday

    with_options format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/, message: 'に全角文字を使用してください' } do
      validates :first_name_kanji
      validates :last_name_kanji
    end

    with_options format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'} do
      validates :first_name_kana
      validates :last_name_kana
    end
  end

  has_many :items
end
