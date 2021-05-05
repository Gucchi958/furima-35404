FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password { "1q1q1q" }
    password_confirmation { "1q1q1q" }
    first_name_kanji { "山田" }
    last_name_kanji{ "旬" }
    first_name_kana{ "ヤマダ" }
    last_name_kana{ "シュン" }
    birthday{ 19960320 }
  end
end
