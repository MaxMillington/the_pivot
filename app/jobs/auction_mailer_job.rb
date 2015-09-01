class AuctionMailerJob < ActiveJob::Base
  queue_as :default

  def perform(auction)
    UserMailer.win_bid(auction.winner).deliver_now
  end

  def perform_auction_notification(seller)
    UserMailer.send_auction_over_email(seller.email).deliver_now
  end

end
