class AddNullFalseToStartingandEndingTime < ActiveRecord::Migration
  def change
    change_column :auctions, :starting_time, :datetime, null: false
    change_column :auctions, :ending_time, :datetime, null: false
  end
end
