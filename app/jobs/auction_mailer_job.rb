class AuctionMailerJob < ActiveJob::Base
  queue_as :default


  def perform(auction)
    UserMailer.contact(auction.winner).deliver_now
  end

end
