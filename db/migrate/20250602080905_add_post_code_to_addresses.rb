class AddPostCodeToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :post_code, :string
  end
end
