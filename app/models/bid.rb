class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  before_save :greater?


  def bid_seller
    self.auction.product.seller
  end

  def outbid_user
    if self.auction.bids.count >= 2
      self.auction.bids[-2].user
    else
      self.user
    end
  end

  def greater?
    if auction.bids.count > 0
      self.amount > auction.bids.last.amount
    else
      self.amount > auction.starting_price
    end
  end

end
