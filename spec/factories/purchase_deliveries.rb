FactoryBot.define do
  factory :purchase_delivery do
    postal_code      {'123-4567'}
    prefecture_id    { 2 }
    municipalities   { '東京都' }
    address          { '1-1' }
    building         { '東京ハイツ' }
    phone_number      { '09012341234' }
    association :user, factory: :user
    association :item, factory: :item

    token {"tok_abcdefghijk00000000000000000"}
  end
end
