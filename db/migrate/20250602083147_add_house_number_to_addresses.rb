class AddHouseNumberToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :house_number, :string
  end
end
