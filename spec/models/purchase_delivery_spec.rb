require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  describe '購入履歴と配送先の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload("/files/test_image.jpg")
      @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: @user, item_id: @item)
    end
    
    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_delivery).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_delivery.building = ''
        expect(@purchase_delivery).to be_valid
      end

      it 'tokenがあれば保存ができること' do
        expect(@purchase_delivery).to be_valid
      end

    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_delivery.postal_code = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_delivery.postal_code = '1234567'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Postal code is invalid")
      end

      it 'prefecture_idが0では保存できないこと' do
        @purchase_delivery.prefecture_id = '0'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Prefecture は---以外を選択して下さい")
      end

      it 'municipalitiesが空だと保存できないこと' do
        @purchase_delivery.municipalities = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Municipalities can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @purchase_delivery.address = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_delivery.phone_number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberは半角数値でないと保存できないこと' do
        @purchase_delivery.phone_number = '１２３'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberは11桁以内の数値でないと保存できないこと' do
        @purchase_delivery.phone_number = '12345'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone number is invalid")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_delivery.item_id = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @purchase_delivery.token = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
      end


    end
  end
end
