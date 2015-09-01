  class PermissionService
  attr_reader :user
  attr_reader :controller
  attr_reader :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user && user.platform_admin?
      platform_admin_permissions
    elsif user && user.seller_admin?
      seller_admin_permissions
    elsif user && user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == 'static_pages' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show feed edit update destroy))
    return true if controller == 'categories' && action.in?(%w(index show))
    return true if controller == 'sellers' && action.in?(%w(index show new create))
    return true if controller == 'products' && action.in?(%w(index show new create edit update destroy))
    return true if controller == 'seller/sellers' && action.in?(%w(index show new create edit update))
    return true if controller == 'auctions' && action.in?(%w(index show))
    return true if controller == 'bids' && action.in?(%w(index show new create edit update))
    return true if controller == 'addresses' && action.in?(%w(new create edit update))
    return true if controller == 'platform_admin/admins' && action.in?(%w(index))
  end

  def seller_admin_permissions
    return true if controller == 'static_pages' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show feed edit update))
    return true if controller == 'categories' && action.in?(%w(index show))
    return true if controller == 'sellers' && action.in?(%w(index show update))
    return true if controller == 'seller/auctions' && action.in?(%w(index new create))
    return true if controller == 'seller/products' && action.in?(%w(index show new create edit update destroy))
    return true if controller == 'seller/sellers' && action.in?(%w(index show new edit update))
    return true if controller == 'auctions' && action.in?(%w(index show))
    return true if controller == 'bids' && action.in?(%w(index show new create edit update))
    return true if controller == 'addresses' && action.in?(%w(new create edit update))
  end

  def registered_user_permissions
    return true if controller == 'static_pages' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show feed edit update))
    return true if controller == 'categories' && action.in?(%w(index show))
    return true if controller == 'sellers' && action.in?(%w(index show))
    return true if controller == 'auctions' && action.in?(%w(index show))
    return true if controller == 'bids' && action.in?(%w(index show new create edit update))
    return true if controller == 'addresses' && action.in?(%w(new create edit update))
  end

  def guest_user_permissions
    return true if controller == 'static_pages' && action == 'index'
    return true if controller == 'sessions' && action.in?(%w(new create))
    return true if controller == 'users' && action.in?(%w(new create))
    return true if controller == 'categories' && action.in?(%w(index show))
    return true if controller == 'sellers' && action.in?(%w(index show))
    return true if controller == 'auctions' && action.in?(%w(index show))
  end
end
