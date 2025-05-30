require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)

    FactoryBot.create(:category, name: "メンズ")
    FactoryBot.create(:condition, name: "新品・未使用")
    FactoryBot.create(:shipping_fee, name: "送料込み（出品者負担）")
    FactoryBot.create(:prefecture, name: "北海道")
    FactoryBot.create(:shipping_day, name: "2〜3日で発送")
  end

  context 'ログインしている場合' do
    it '商品出品ページに遷移できる' do
      sign_in(@user)
      visit root_path
      find('#new-item-link').click
      expect(current_path).to eq new_item_path
    end

    it '必要情報を入力して出品するとトップページに戻り商品が表示される' do
      sign_in(@user)
      visit new_item_path

     attach_file 'item-image', Rails.root.join('spec/fixtures/test_image.png'), make_visible: true
     fill_in 'item-name', with: 'テスト商品'
     fill_in 'item-info', with: 'これはテスト用の商品説明です。'
     save_page
     find('#item-sales-status').find('option', text: '新品・未使用').select_option
     expect(page).to have_select('item-shipping-fee-status')
     select '送料込み（出品者負担）', from: 'item-shipping-fee-status'
     select '北海道', from: 'item-prefecture'
     select '2〜3日で発送', from: 'item-scheduled-delivery'
     fill_in 'item-price', with: 3000
     click_button '出品する'


      expect(current_path).to eq root_path
      expect(page).to have_content 'テスト商品'
    end

    it '入力に不備があると出品できずエラー表示され、入力は保持される（画像以外）' do
      sign_in(@user)
      visit new_item_path

      fill_in 'item-name', with: ''
      fill_in 'item-info', with: '説明のみ'

      click_button '出品する'

      expect(page).to have_content '商品名を入力してください'
      expect(find_field('item-info').value).to eq '説明のみ'
    end
  end

  context 'ログアウト状態の場合' do
    it '出品ページにアクセスするとログインページに遷移する' do
      visit new_item_path
      expect(current_path).to eq new_user_session_path
    end
  end
end
