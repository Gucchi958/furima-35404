FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    first_name_kanji { "山田" }
    last_name_kanji{ "旬" }
    first_name_kana{ "ヤマダ" }
    last_name_kana{ "シュン" }
    birthday{ 19960320 }
  end
end
