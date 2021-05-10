require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload("/files/test_image.jpg")
  end

  describe '商品出品登録' do
    
    context '出品登録できるとき' do

      it '必須項目が全てあれば登録できること' do
        expect(@item).to be_valid
      end

    end

    context '出品登録できないとき' do
      
      it '商品名が必要であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が必要であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリー情報が必要であること' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category は---以外を選択して下さい")
      end

      it '商品状態が必要であること' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status は---以外を選択して下さい")
      end

      it '配送料の負担に関しての情報が必須であること' do
        @item.charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge は---以外を選択して下さい")
      end

      it '発送元の地域に関しての情報が必須であること' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture は---以外を選択して下さい")
      end

      it '発送までの日数に関しての情報が必須であること' do
        @item.day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Day は---以外を選択して下さい")
      end

      it '販売価格の情報が必須であること' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price Out of setting range")
      end

      it '販売価格は半角数字のみ登録可能であること' do
        @item.price = "１００００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字で入力して下さい")
      end

      it '販売価格300円以下は登録できない' do
        @item.price = 150
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end

      it '販売価格9,999,999円以上は登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end

      it '商品画像が必須であること' do
        @item.image.key = ''
        @item.valid?
        expect(@item.errors.full_messages).to include{"Image can't be blank"}
      end
    end
  end
end
