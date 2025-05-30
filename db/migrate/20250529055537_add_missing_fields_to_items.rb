class AddMissingFieldsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :condition_id, :integer
    add_column :items, :shipping_fee_id, :integer
    add_column :items, :prefecture_id, :integer
    add_column :items, :shipping_day_id, :integer
  end
end
