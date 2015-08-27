class AddCategoryIdToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :category, index: true, foreign_key: true
  end
end
