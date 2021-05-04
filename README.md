# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル
| Column             | Type    | Options                    |
| ------------------ | ------- | -------------------------- |
| nickname           | String  | null: false                |
| email              | String  | null: false, unique: true  |
| encrypted_password | String  | null: false                |
| first_name_kanji   | String  | null: false                |
| last_name_kanji    | String  | null: false                |
| first_name_kana    | String  | null: false                |
| lase_name_kana     | String  | null: false                |
| birthday           | date    | null: false                |

### Association
- has_many :items
- has_many :purchases


## items テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| name             | String     | null: false                     |
| description      | text       | null: false                     |
| category_id      | integer    | null: false                     |
| status_id        | integer    | null: false                     |
| charge_id        | integer    | null: false                     |
| area_id          | integer    | null: false                     |
| day_id           | integer    | null: false                     |
| price            | integer    | null: false                     |
| user             | references | null: false, foreign_keys: true |

### Association
- belongs_to :user
- has_one :purchase


## purchases テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| user             | references | null: false, foreign_keys: true |
| item             | references | null: false, foreign_keys: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :delivery

## deliveries テーブル

| Column              | Type       | Options                         |
| ------------------- | ---------- | ------------------------------- |
| postal_code         | string     | null: false                     |
| prefecture_id       | integer    | null: false                     |
| municipalities      | string     | null: false                     |
| address             | string     | null: false                     |
| building            | string     | null: false                     |
| phone_number        | integer    | null: false                     |
| purchase            | references | null: false, foreign_keys: true |

### Association
- belongs_to :purchase