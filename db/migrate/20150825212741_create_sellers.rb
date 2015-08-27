class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :name
      t.string :slug
      t.string :email

      t.timestamps null: false
    end
  end
end
