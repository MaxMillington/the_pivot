class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  before_save :greater?

  def greater?
    if auction.bids.count > 0
      self.amount > auction.bids.last.amount
    else
      self.amount > auction.starting_price
    end
  end

end
