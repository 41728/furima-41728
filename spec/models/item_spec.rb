require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)  # 正常な初期状態
  end

  describe '商品出品' do
    context '出品できる場合' do
      it 'すべての情報が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name 商品名を入力してください")
      end

      it '説明がないと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが未選択（idが1）だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end

      it '商品の状態が未選択だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end

      it '配送料の負担が未選択だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee を選択してください")
      end

      it '発送元の地域が未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '発送までの日数が未選択だと出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day を選択してください")
      end

      it '価格が空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の範囲で入力してください")
      end

      it '価格が9,999,999を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の範囲で入力してください")
      end

      it '価格が全角数字では出品できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の範囲で入力してください")
      end
    end
  end
end
