class Item < ApplicationRecord

  with_options presence: true do

    validates :name
    validates :description
    validates :image

    with_options numericality: {other_than: 0, message: "は---以外を選択して下さい" } do
      validates :category_id
      validates :status_id
      validates :charge_id
      validates :prefecture_id
      validates :day_id
    end
    
    with_options numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力して下さい' } do
      validates :price
    end
    
  end

  with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300~9999999の範囲内で入力して下さい' } do
    validates :price
  end

  belongs_to :user
  has_one :purchase, dependent: :destroy
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :charge
  belongs_to :status
  belongs_to :day

end
