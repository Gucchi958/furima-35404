class PurchaseDelivery < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number, :item_id, :user_id


  with_options presence: true do

    validates :item_id
    validates :user_id
    validates :municipalities
    validates :address
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :phone_number, format: {with: /\A[0-9]{11}\z/ }

    with_options numericality: {other_than: 0, message: "は---以外を選択して下さい" } do
      validates :prefecture_id
    end

  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end


