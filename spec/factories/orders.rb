FactoryBot.define do
  factory :order do  # 小文字のorderにする
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    address { '青葉区1-1-1' }
    building_name { '青葉マンション101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
