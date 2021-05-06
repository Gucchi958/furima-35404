require 'rails_helper'

RSpec.describe User, type: :model do
    before do
      @user = FactoryBot.build(:user)
    end
    
    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it 'nicknameとemail、passwordとpassword_confirmation、first_name_kanji、last_name_kanji、first_name_kana、last_name_kana、birthdayが存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'passwordが6文字以上かつ半角英数字混合であれば登録できること' do
          @user.password = '12345a'
          @user.password_confirmation = '12345a'
          expect(@user).to be_valid
        end
      end

      context '新規登録できないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できないこと' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'passwordが空では登録できないこと' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'first_name_kanjiが空では登録できないこと' do
          @user.first_name_kanji = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kanji can't be blank")
        end

        it 'last_name_kanjiが空では登録できないこと' do
          @user.last_name_kanji = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
        end

        it 'first_name_kanaが空では登録できないこと' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end

        it 'last_name_kanaが空では登録できないこと' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        end

        it 'birthdayが空では登録できないこと' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end   
        
        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = '12a45'
          @user.password_confirmation = '12a45'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it '重複したemailが存在する場合登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'password:半角英数混合(半角英語のみ)でないと登録できないこと' do
          @user.password = 'aaaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'password:半角英数混合(半角英語のみ)でないと登録できないこと' do
          @user.password = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'emailに@がないと登録できないこと' do
          @user.email = 'aaagmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end

        it 'first_name_kanjiが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
          @user.first_name_kanji = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kanji に全角文字を使用してください")
        end

        it 'last_name_kanjiが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
          @user.last_name_kanji = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kanji に全角文字を使用してください")
        end

        it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
          @user.first_name_kana = 'ああああ'
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana はカタカナで入力して下さい。")
        end

        it 'last_name_kanaが全角（カタカナ）でないと登録できない' do
          @user.last_name_kana = 'ああああ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana はカタカナで入力して下さい。")
        end


      end
    end
end
