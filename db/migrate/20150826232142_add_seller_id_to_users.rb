class AddSellerIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :seller, index: true, foreign_key: true
  end
end
