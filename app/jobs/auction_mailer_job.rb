class AuctionMailerJob < ActiveJob::Base
  queue_as :default


  def perform(auction)
    NotificationsMailer.contact(auction.winner).deliver_now
  end

end
