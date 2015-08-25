class Auction < ActiveRecord::Base
  belongs_to :product
  has_many :bids
end
