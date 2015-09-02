class StaticPagesController < ApplicationController
  def index
    @auctions = Auction.active.sample(6)
  end
end
