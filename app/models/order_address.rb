class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address,
                :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
  end

  def save
    order = Order.new(user_id: user_id, item_id: item_id)
    unless order.save
      Rails.logger.error("Order保存失敗: #{order.errors.full_messages.join(', ')}")
      return false
    end

    address = Address.new(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: self.address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
    unless address.save
      Rails.logger.error("Address保存失敗: #{address.errors.full_messages.join(', ')}")
      return false
    end

    true
  end
end
