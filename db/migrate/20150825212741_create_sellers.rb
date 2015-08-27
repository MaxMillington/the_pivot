class CreateSellers < ActiveRecord::Migration
  def change
    create_table :seller do |t|
      t.string :name
      t.string :slug
      t.string :email

      t.timestamps null: false
    end
  end
end
