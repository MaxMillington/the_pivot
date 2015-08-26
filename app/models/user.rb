class User < ActiveRecord::Base
  has_secure_password
  has_many :bids
  has_many :auctions, through: :bids
  has_many :addresses, as: :addressable
  has_many :user_roles
  has_many :roles, through: :user_roles

  before_save :default_role
  before_validation :strip_whitespace
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, length: { minimum: 8 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def seller_admin?
    roles.exists?(name: 'seller_admin')
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end

  private

  def strip_whitespace
    self.first_name = first_name.strip if first_name
    self.last_name = last_name.strip if last_name
    self.email = email.strip if email
  end

  def default_role
    self.role ||= 'registered_user'
  end

end
