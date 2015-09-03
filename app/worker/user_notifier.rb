class UserNotifier
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    UserMailer.win_bid(auction.bids.last.user).deliver_now
  end
end
