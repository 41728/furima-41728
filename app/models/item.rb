class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHash モデルとの関連付け
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :price
  end

  # 「---」（id = 1）を選ばせないバリデーション
  validates :category_id,        numericality: { other_than: 1, message: "を選択してください" }
  validates :condition_id,       numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_fee_id,    numericality: { other_than: 1, message: "を選択してください" }
  validates :prefecture_id,      numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_day_id,   numericality: { other_than: 1, message: "を選択してください" }

  # 価格の範囲および半角数値であること
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: "は¥300〜¥9,999,999の範囲で入力してください"
            }
end