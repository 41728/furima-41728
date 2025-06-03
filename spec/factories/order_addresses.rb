FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    house_number { '青葉区1-1-1' }
    building_name { '青葉マンション101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

    # user_id と item_id はテスト内でセットするため、ここでは省略
  end
end
