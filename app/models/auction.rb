class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
  has_many :users, through: :bids

  scope :category_id, -> (category_id) { where category_id: category_id }

  def winning_bid_amount
    bid = bids.max_by { |bid| bid.amount }
    bid.amount
  end

end
