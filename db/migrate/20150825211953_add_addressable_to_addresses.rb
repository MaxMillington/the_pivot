class AddAddressableToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :addressable_type, :string
    rename_column :addresses, :user_id, :addressable_id
  end
end
