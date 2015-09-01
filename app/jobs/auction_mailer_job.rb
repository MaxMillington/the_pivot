class AuctionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(auction)
    UserMailer.win_bid(auction.winner).deliver_now
  end

end
