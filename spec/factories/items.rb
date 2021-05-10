FactoryBot.define do
  factory :item do
    name { "商品名" }
    description { "説明" }
    category_id { 2 }
    status_id { 2 }
    charge_id { 2 }
    prefecture_id { 2 }
    day_id { 3 }
    price { 10000 }
    association :user, factory: :user
  end
end
