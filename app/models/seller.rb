class Seller < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :products, dependent: :destroy
  has_many :auctions, through: :products, dependent: :destroy
  has_many :users, dependent: :destroy

  before_validation :strip_whitespace
  before_validation :add_slug
  validates :name, presence: true
  validates :email, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :slug, uniqueness: true

  def send_seller_bid_email
    SellerMailer.send_seller_bid_email(self).deliver_now
  end

  def send_auction_over_email
    SellerMailer.send_auction_over_email(self).deliver_now
  end


  protected

  def add_slug
    self.slug = "#{name}".parameterize if name
  end

  def strip_whitespace
    self.name = name.strip if name
    self.email = email.strip if email
  end

end
