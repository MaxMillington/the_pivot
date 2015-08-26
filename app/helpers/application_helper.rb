module ApplicationHelper

  def registered_user?
    current_user && current_user.registered_user?
  end

  def seller_admin?
    current_user && current_user.seller_admin?
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end
end
