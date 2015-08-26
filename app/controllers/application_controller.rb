class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :authorize!

  def load_featured_products
    @featured_products = Product.limit(6).order("RANDOM()")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    redirect_to root_path, danger: "Action not allowed." unless authorized?
  end

  private

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
