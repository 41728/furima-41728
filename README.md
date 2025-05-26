# README

## Users
|Column            |Type  |Options                  |
|nickname          |string|null: false              |
|email             |string|null: false, unique: true|
|encrypted_password|string|null: false              |
|last_name         |string|null: false              |
|first_name        |string|null: false              |
|last_name_kana    |string|null: false              |
|first_name_kana   |string|null: false              |
|birth_date        |date  |null: false              |

### [User]
- has_many :items
- has_many :purchases



## Items
|Column            |Type      |Options                      |
|name              |string    |null: false                  |
|description       |text      |null: false                  |
|price             |integer   |null: false                  |
|user              |references|null: false foreign_key: true|
|category_id       |integer   |null: false                  |
|item_condition_id |integer   |null: false                  |
|delivery_charge_id|integer   |null: false                  |
|shipping_region_id|integer   |null: false                  |
|shipping_day_id   |integer   |null: false                  |

### [Item]
- belongs_to :user
- has_one :purchase
- belongs_to :category
- belongs_to :item_condition
- belongs_to :delivery_charge
- belongs_to :shipping_region
- belongs_to :shipping_day



## Purchases
|Column|Type      |Options                       |
|user  |references|null: false, foreign_key: true|
|item  |references|null: false, foreign_key: true|

### [Purchase]
- belongs_to :user
- belongs_to :item
- has_one :shipping_address



## ShippingAddresses
|Column            |Type      |Options                       |
|purchase          |references|null: false, foreign_key: true|
|postal_code       |string    |null: false                   |
|shipping_region_id|integer   |null: false                   |
|city              |string    |null: false                   |
|address           |string    |null: false                   |
|building_name     |string    |                              |
|phone_number      |string    |null: false                   |

### [ShippingAddress]
- belongs_to :purchase

