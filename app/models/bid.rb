class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  before_save :greater?

  def greater?
    self.amount > auction.bids.last.amount
  end

end
