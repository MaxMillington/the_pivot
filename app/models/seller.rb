class Seller < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :products
  has_many :auctions, through: :products
  has_many :users

  before_validation :strip_whitespace
  before_validation :add_slug
  validates :name, presence: true
  validates :email, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :slug, uniqueness: true

  protected

  def add_slug
    self.slug = "#{name}".parameterize if name
  end

  def strip_whitespace
    self.name = name.strip if name
    self.email = email.strip if email
  end

end
