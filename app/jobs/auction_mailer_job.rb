class AuctionMailerJob < ActiveJob::Base
  queue_as :default

  def perform_later(winner)

  end
end
