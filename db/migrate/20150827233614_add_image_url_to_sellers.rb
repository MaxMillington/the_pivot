class AddImageUrlToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :image_url, :string
  end
end
