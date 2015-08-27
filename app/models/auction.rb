class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  has_many :users, through: :bids

  def winning_bid_amount
    bid = bids.max_by { |bid| bid.amount }
    bid.amount
  end

  def time_remaining
    distance_of_time_in_words(Time.now, ending_time)
  end

end
