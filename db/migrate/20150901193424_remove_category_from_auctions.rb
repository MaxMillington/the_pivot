class RemoveCategoryFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :category_id, :integer, index: true
  end
end
