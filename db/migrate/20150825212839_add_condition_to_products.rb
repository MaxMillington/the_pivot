class AddConditionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :condition, :string
    add_reference :products, :seller, index: true, foreign_key: true
    remove_column :products, :status
    remove_column :products, :price
  end
end
