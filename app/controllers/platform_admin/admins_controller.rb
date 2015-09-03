class PlatformAdmin::AdminsController < ApplicationController
  def index
    @sellers = Seller.all
  end
end
