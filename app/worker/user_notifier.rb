class UserNotifier
  include Sidekiq::Worker

  def perform(auction_id)
    auction = Auction.find(auction_id)
    UserMailer.win_bid(auction.winner).deliver_now
  end
end
