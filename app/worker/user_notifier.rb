class UserNotifier
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(aution_id)
    UserMailer.win_bid(auction.winner).deliver_now
  end
end
