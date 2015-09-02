class UserNotifier
  include Sidekiq::Worker

  def perform(auction)
    UserMailer.win_bid(auction.winner).deliver_now
  end
end