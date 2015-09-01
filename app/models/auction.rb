class Auction < ActiveRecord::Base
  belongs_to :product
  has_one :category, through: :product
  has_many :bids
  has_many :users, through: :bids

  validates :starting_price, presence: true

  def self.active
    where('starting_time <= ?', Time.now)
        .where('ending_time >= ?', Time.now)
  end

  def winning_bid_amount
    bid = bids.max_by { |bid| bid.amount }
    bid.amount
  end

  def winner
    bids.last.user
  end
end
