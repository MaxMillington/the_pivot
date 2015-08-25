class Seller < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :products
  has_many :auctions, through: :products

end
