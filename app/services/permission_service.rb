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
    return true if controller == 'stores' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(index show))
    return true if controller == 'users' && action.in?(%w(index show))
  end

  def seller_admin_permissions
    return true if controller == 'stores' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(index show))

  end

  def registered_user_permissions
    return true if controller == 'static_pages' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
  end

  def guest_user_permissions
    return true if controller == 'static_pages' && action == 'index'
    return true if controller == 'sessions' && action.in?(%w(new create))
    return true if controller == 'users' && action.in?(%w(new create))
  end
end