class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :product, index: true, foreign_key: true
      t.datetime :starting_time
      t.datetime :ending_time
      t.decimal :starting_price

      t.timestamps null: false
    end
  end
end
