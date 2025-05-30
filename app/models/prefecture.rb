class Prefecture < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '北海道' },
    { id: 3, name: '青森県' },
    { id: 4, name: '岩手県' },
    { id: 5, name: '宮城県' },
    { id: 6, name: '秋田県' },
    { id: 7, name: '山形県' },
    { id: 8, name: '福島県' },
    # ...都道府県をすべて追加
    { id: 48, name: '沖縄県' }
  ]

  include ActiveHash::Associations
  has_many :items
end