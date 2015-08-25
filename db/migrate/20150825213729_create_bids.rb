class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :auction, index: true, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
